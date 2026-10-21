-- 04_burnout_analysis.sql
-- Business question: does burnout line up with attrition and with risk?
-- Note: Burnout is built from overtime, work-life balance, job satisfaction and promotion gap,
-- which overlap with the risk score inputs, so this is a consistency check, not independent proof.

-- 4.1 Burnout level distribution with attrition rate and average risk score
SELECT
    BurnoutLevel,
    COUNT(*) AS employees,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate,
    ROUND(AVG(AttritionRiskScore), 2) AS avg_risk_score
FROM employees
GROUP BY BurnoutLevel
ORDER BY avg_risk_score DESC;

-- 4.2 Burnout level by department (heatmap input)
SELECT
    Department,
    BurnoutLevel,
    COUNT(*) AS employees
FROM employees
GROUP BY Department, BurnoutLevel
ORDER BY Department, BurnoutLevel;
