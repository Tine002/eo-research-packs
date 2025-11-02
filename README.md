# EO 14067 Research Pack

Receipts-first bundle for Executive Order 14067 and its policy aftermath, rebuilt clean from this chat.

**Primary receipts**
- EO 14067 (Federal Register): https://www.federalregister.gov/documents/2022/03/14/2022-05471/ensuring-responsible-development-of-digital-assets
- EO 14067 (GovInfo PDF): https://www.govinfo.gov/content/pkg/CFR-2023-title3-vol1/pdf/CFR-2023-title3-vol1-eo14067.pdf
- EO 14178 (Federal Register): https://www.federalregister.gov/documents/2025/01/31/2025-02123/strengthening-american-leadership-in-digital-financial-technology
- EO 14178 (GovInfo excerpt/PDF): https://www.govinfo.gov/content/pkg/DCPD-202500169/pdf/DCPD-202500169.pdf

## Contents
- `docs/eo/14067/sections/` S-level sections (abstract, impact, myth-vs-fact, CBDC brief, policy snapshot, mandate-output tracker, illicit-finance, energy/climate card, comparative law, timeline, stakeholder map, scenarios)
- `docs/eo/14067/records.jsonl` simple JSONL extract set (non-empty)
- `docs/eo/14067/crossrefs.json` revision graph
- `docs/eo/14067/scenarios.json` scenario inputs
- `extras/schemas/*.json` JSON Schemas
- `scripts/build.ps1` one-shot site build (renders index.html, zips bundle, prints SHA256)

## Build
Open PowerShell in repo root and run:

```powershell
scripts\build.ps1
```
