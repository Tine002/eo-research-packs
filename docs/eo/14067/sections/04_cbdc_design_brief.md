# CBDC design brief with privacy options

Two pages to demystify common choices. Keep it receipts-anchored; do not imply endorsement.

## High-level choices
- **Account-based vs token-based** access models. <PIN_BIS/OSTP_DEFS>
- **Tiered privacy** (small offline payments with higher privacy vs large AML-gated transfers). <PIN_PRIVACY_TRADEOFFS>
- **Offline capability** (resilience vs reconciliation complexity). <PIN_OFFLINE_DOCS>
- **AML/CFT controls** touchpoints (onboarding, transfers above thresholds, redemption). <PIN_TREASURY/FINCEN>

## Simple matrix (illustrative)
| Option | Fraud resilience | Privacy at point of sale | Offline feasibility | AML friction |
|---|---:|---:|---:|---:|
| Account + strong KYC | High | Low–Med | Low | High |
| Token + tiered KYC | Med | Med–High | Med | Med |
| Token + offline small-value | Med | High (for small tx) | High | Tiered |

> Replace each `<PIN_…>` with the cited page in OSTP/BIS/Treasury sources.