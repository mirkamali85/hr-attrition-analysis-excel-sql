-- 07_views_and_workforce_structure.sql
-- Reusable views for dashboards, plus the workforce structure query.

DROP VIEW IF EXISTS high_risk_employees;
CREATE VIEW high_risk_employees AS
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    AttritionRiskScore,
    BurnoutLevel,
    OverTime
FROM employees
WHERE AttritionRiskScore >= 0.7;

DROP VIEW IF EXISTS executive_hr_kpis;
CREATE VIEW executive_hr_kpis AS
SELECT
    Department,
    COUNT(*) AS total_employees,
    ROUND(AVG(MonthlyIncome), 2) AS avg_salary,
    ROUND(AVG(Burnout), 2) AS avg_burnout,
    ROUND(AVG(AttritionRiskScore), 2) AS avg_risk_score,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY Department;

-- Use the views
SELECT * FROM executive_hr_kpis ORDER BY attrition_rate DESC;
SELECT COUNT(*) AS high_risk_count FROM high_risk_employees;

-- Workforce distribution by department and gender
SELECT
    Department,
    Gender,
    COUNT(*) AS total_employees,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Department), 2) AS gender_percentage
FROM employees
GROUP BY Department, Gender
ORDER BY Department, Gender;
