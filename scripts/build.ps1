Param()

$ErrorActionPreference = "Stop"
$Owner   = "Tine002"
$Repo    = "eo-research-packs"
$EONum   = "14067"
$root    = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location (Split-Path -Parent $root)  # repo root

$docs   = "docs"
$eoDir  = Join-Path $docs "eo\$EONum"
$secDir = Join-Path $eoDir "sections"
$dlDir  = Join-Path $docs "downloads"
$extras = "extras"
$ogTags = Join-Path $extras "og_tags.html"

# Build bundle markdown
$bundleMd = Join-Path $env:TEMP "eo${EONum}_bundle.md"
$toc = @"
# EO ${EONum} - Ensuring Responsible Development of Digital Assets

Primary receipts: [FR 14067](https://www.federalregister.gov/documents/2022/03/14/2022-05471/ensuring-responsible-development-of-digital-assets) · [GovInfo PDF](https://www.govinfo.gov/content/pkg/CFR-2023-title3-vol1/pdf/CFR-2023-title3-vol1-eo14067.pdf) · [FR 14178](https://www.federalregister.gov/documents/2025/01/31/2025-02123/strengthening-american-leadership-in-digital-financial-technology) · [GovInfo excerpt](https://www.govinfo.gov/content/pkg/DCPD-202500169/pdf/DCPD-202500169.pdf)

## Contents
"@
$toc | Set-Content $bundleMd -Encoding UTF8

Get-ChildItem $secDir -Filter *.md | Sort-Object Name | ForEach-Object {
  Add-Content $bundleMd ("* " + (Get-Content $_.FullName -TotalCount 1).Replace("# ",""))
}
Get-ChildItem $secDir -Filter *.md | Sort-Object Name | ForEach-Object {
  Add-Content $bundleMd "`n`n---`n"
  Get-Content $_.FullName | Add-Content $bundleMd
}

# Render via GitHub API; fallback to <pre>
try {
  $payload = @{ text = (Get-Content $bundleMd -Raw); mode = "gfm" } | ConvertTo-Json -Compress
  $htmlBody = $payload | gh api --method POST markdown --input -
} catch {
  $raw = [System.Net.WebUtility]::HtmlEncode((Get-Content $bundleMd -Raw))
  $htmlBody = "<pre class='markdown-raw'>${raw}</pre>"
}

$indexHtml = @"
<!doctype html><html lang="en"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>EO ${EONum} - Ensuring Responsible Development of Digital Assets</title>
$(Get-Content $ogTags -Raw)
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/github-markdown-css@5.5.1/github-markdown-light.min.css">
<style>main{max-width:860px;margin:2rem auto;padding:0 1rem}.markdown-body{max-width:860px;margin:0 auto}footer{border-top:1px solid #eee;margin-top:2rem;color:#666}</style>
</head><body>
<main class="markdown-body">
${htmlBody}
</main>
<footer><small>Datasets: records.jsonl, crossrefs.json, scenarios.json. SHA256 in downloads/checksums.json.</small></footer>
</body></html>
"@
Set-Content (Join-Path $eoDir "index.html") $indexHtml -Encoding UTF8

# ZIP + checksum
$zip = Join-Path $dlDir "EO${EONum}_bundle_v02.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $eoDir "*") -DestinationPath $zip -CompressionLevel Optimal
$sha = (Get-FileHash $zip -Algorithm SHA256).Hash
@{ file = (Split-Path $zip -Leaf); sha256 = $sha } | ConvertTo-Json | Set-Content (Join-Path $dlDir "checksums.json") -Encoding UTF8

"`nBuilt: $zip`nSHA256: $sha"
