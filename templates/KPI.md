# KPI Definition

<!-- CONTRACT: Written by the kpi-definition skill (phase 1). Revised only by the
     launch-kpi-loop skill once real data exists. All six sections are mandatory.
     Every downstream decision must cite a driver-tree node from this file. -->

## North Star
- **KPI:** {{e.g. MRR}}
- **Definition:** {{precise, e.g. "sum of active subscription amounts at month end"}}
- **Unit / window:** {{e.g. EUR per month, measured monthly}}

## Driver Tree
```mermaid
graph TD
  NS[{{North star}}] --> A[{{driver 1}}]
  NS --> B[{{driver 2}}]
  A --> C[{{sub-driver}}]
  A --> D[{{sub-driver}}]
```

| Node | Definition | Unit | Data source (instrumentable in-product) |
|------|-----------|------|------------------------------------------|
| {{MRR}} | {{…}} | {{EUR/month}} | {{Stripe subscriptions API}} |
| {{paying users}} | {{…}} | {{count}} | {{DB: subscriptions table}} |
| {{signups}} | {{…}} | {{count/week}} | {{DB: users table, created_at}} |
| {{traffic}} | {{…}} | {{visits/week}} | {{server-side request log / analytics}} |

## Metric Definitions
{{One short paragraph per non-obvious metric: edge cases, exclusions (e.g. trials,
refunds), exact events that count.}}

## Targets & Assumptions (90 days)
<!-- Order-of-magnitude estimates. ALL pre-launch targets are assumptions; the
     launch-kpi-loop revises them against real data. -->
| Node | 90-day target | Assumption behind it |
|------|---------------|----------------------|
| {{node}} | {{value}} | {{why this is plausible}} |

## Guardrails
<!-- Metrics that decisions must NOT degrade, even if they help the north star. -->
- {{e.g. monthly churn < X%}}
- {{e.g. refund rate < Y%}}

## Decision Rule
A decision is KPI-justified if it plausibly improves a named driver-tree node without
violating a guardrail. Every DECISIONS.md entry must cite the node.
