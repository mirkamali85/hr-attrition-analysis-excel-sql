-- 06_window_functions.sql
-- Ranking, segmentation and comparison with window functions.

-- 6.1 Tenure segmentation
SELECT
    EmployeeNumber,
    YearsAtCompany,
    CASE
        WHEN YearsAtCompany < 2 THEN 'New Hire'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN 'Early Career'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN 'Mid Career'
        ELSE 'Long Tenure'
    END AS tenure_group
FROM employees;

-- 6.2 Highest-paid employees within each department
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS salary_rank
FROM employees;

-- 6.3 Attrition risk ranking across the company
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    AttritionRiskScore,
    DENSE_RANK() OVER (ORDER BY AttritionRiskScore DESC) AS risk_rank
FROM employees;

-- 6.4 Each employee's pay compared with their department average
SELECT
    Department,
    JobRole,
    MonthlyIncome,
    ROUND(AVG(MonthlyIncome) OVER (PARTITION BY Department), 2) AS dept_avg_salary,
    ROUND(MonthlyIncome - AVG(MonthlyIncome) OVER (PARTITION BY Department), 2) AS diff_from_dept_avg
FROM employees;
