-- 05_salary_risk_and_promotion.sql
-- Business questions: where is the risk, does pay matter, and does promotion lag matter?

-- 5.1 Salary bands: size, pay, risk score and actual attrition
SELECT
    SalaryBands,
    COUNT(*) AS employees,
    ROUND(AVG(MonthlyIncome), 0) AS avg_salary,
    ROUND(AVG(AttritionRiskScore), 2) AS avg_risk,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY SalaryBands
ORDER BY avg_salary;

-- 5.2 High-risk employees (risk score 0.7 or higher)
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    BurnoutLevel,
    AttritionRiskScore
FROM employees
WHERE AttritionRiskScore >= 0.7
ORDER BY AttritionRiskScore DESC;

-- 5.3 Does the risk score separate leavers from stayers? (score bands decided in advance)
SELECT
    CASE
        WHEN AttritionRiskScore < 0.3 THEN '1. Low (below 0.30)'
        WHEN AttritionRiskScore < 0.6 THEN '2. Medium (0.30 to 0.59)'
        ELSE '3. High (0.60 and above)'
    END AS risk_band,
    COUNT(*) AS employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY 1
ORDER BY 1;

-- 5.4 Promotion stagnation level vs attrition
SELECT
    StagnationLevel,
    COUNT(*) AS employees,
    ROUND(AVG(YearsSinceLastPromotion), 2) AS avg_years_without_promotion,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY StagnationLevel
ORDER BY avg_years_without_promotion DESC;

-- 5.5 Does delayed promotion increase attrition?
-- Result: leavers had a SHORTER average gap since last promotion, so no support for that idea.
SELECT
    Attrition,
    ROUND(AVG(YearsSinceLastPromotion), 2) AS avg_promotion_gap,
    ROUND(AVG(AttritionRiskScore), 2) AS avg_risk_score
FROM employees
GROUP BY Attrition;
