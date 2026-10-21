# HR Attrition Analysis: Excel and SQL (IBM HR Analytics dataset)

**Prepared by:** Kimia Mirkamali

## Objective
Analyse the public IBM HR Analytics employee dataset (1,470 employees) to find where attrition is concentrated, what is associated with it, and which employee groups carry the most risk. The analysis was done in an interactive Excel dashboard and again in SQL (PostgreSQL). Overall, department and overtime attrition are the same in both. Salary-band percentages differ slightly because the two use different cut-offs (Excel: 3,000 and 7,000; SQL: 4,000 and 8,000).

> This is a self-directed practice project on a public sample dataset, not data from an employer.
>
> **Data source:** IBM HR Analytics Employee Attrition & Performance, a fictional dataset published for analytics practice (available on Kaggle).

## Tools
Open `01_Excel/IBM_HR_Attrition_Dashboard.xlsx` for the dashboard and `02_SQL/` for the queries.

- **Excel:** PivotTables and PivotCharts, slicers, XLOOKUP employee profile, conditional formatting, KPI cards, calculated risk and burnout scores
- **SQL (PostgreSQL / pgAdmin):** aggregation, CTEs, window functions (RANK, DENSE_RANK, SUM/AVG OVER), CASE segmentation, views

## Key findings
| Finding | Evidence |
|---|---|
| Overall attrition is 16.1% | 237 of 1,470 employees left |
| Overtime is the strongest single factor | 30.5% attrition with overtime vs 10.4% without (about 3 times higher) |
| The overtime effect appears inside every department | Sales 37.5% vs 13.8%, R&D 27.3% vs 8.6%, HR 29.4% vs 15.2% |
| Early tenure is the riskiest period | 34.9% leave within 0-2 years, falling to 15.5%, 12.3% and 8.1% for longer tenure |
| Attrition is concentrated in the low salary band | 25.3% in the low band vs 11.0% (medium) and 10.5% (high) |
| Sales (20.6%) and HR (19.0%) lose more people than R&D (13.8%) | Overtime rates are almost the same (27-29%), so overtime does not explain the gap between departments |
| Promotion lag does not explain attrition in this data | Leavers had a shorter average gap since last promotion (1.95 years) than stayers (2.23) |
| The weighted risk score separates groups | Attrition is 6.8% (score below 0.30), 17.1% (0.30 to 0.59) and 28.5% (0.60 and above) |

## Method notes
- **Attrition risk score** = (OverTime x 1.5 + low job satisfaction x 2.5 + low work-life balance x 2 + low salary x 1.5 + low environment satisfaction x 2 + no promotion for 5+ years x 0.5) / 10. The weights are analyst judgement, not fitted by a model.
- **Burnout score** = (OverTime x 4 + low work-life balance x 3 + low job satisfaction x 2 + no promotion for 5+ years x 1) / 10.
- **Salary bands:** Low below 4,000, Medium 4,000-7,999, High 8,000 and above (monthly income).
- **Risk category:** High = top 20% of scores, Medium = score at or above the median, Low = the rest.

## Limitations
- The data is a public sample dataset; results describe this dataset only.
- Associations, not causes: the data cannot show that overtime *causes* people to leave.
- The risk score is scored on the same data it was built from, so it is a risk-scoring approach, not a validated prediction model.
- Burnout shares inputs with the risk score, so their agreement is partly built in.
- Groups such as 0-2 year tenure (215 people) and HR (63 people) are small; read their percentages with care.

## Folder structure
```
01_Excel/               IBM_HR_Attrition_Dashboard.xlsx: interactive dashboard (PivotTables, slicers, KPI cards, XLOOKUP employee profile); the Findings sheet lists the figures
02_SQL/                 7 files, run in order 01 to 07
03_Data/employees.csv   data with the engineered columns (load with the command in 01_table_creation.sql)
04_Screenshots/         query results from pgAdmin (taken before the risk score was stored with 2 decimals, so the average risk scores differ slightly from Query_Results.md; attrition and promotion-gap values are the same)
05_Documentation/       SQL design notes and Query_Results.md (output of every script)
06_Insights/            written findings and recommendations
```

## How to run the SQL
1. Run `02_SQL/01_table_creation.sql` in PostgreSQL.
2. Load `03_Data/employees.csv` (psql command is at the bottom of that file, or use the pgAdmin import wizard with "header" on).
3. Run files 02 to 07 in order.
