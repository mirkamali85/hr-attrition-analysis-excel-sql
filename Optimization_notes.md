# SQL Design Notes: HR Analytics Project

## 1. CTEs
Common Table Expressions break complex queries into logical steps, which improves readability and makes each step easy to check.

## 2. Window functions instead of self-joins
Window functions (RANK, DENSE_RANK, SUM OVER, AVG OVER) handle ranking, within-group percentages and comparisons to group averages in a single pass, without self-joins.

## 3. Aggregating first
Where possible, data is aggregated at department level before further calculations, so the logic stays simple.

## 4. Reusable views
Views (`high_risk_employees`, `executive_hr_kpis`) hold logic that a dashboard can reuse.

## 5. Business-first design
Each query starts from a business question, not from exploring the raw table.

## 6. Checks
Overall, department and overtime attrition were cross-checked against the Excel pivot tables. The dataset is small (1,470 rows), so performance was not a constraint here, and the choices above are about clarity and maintainability.
