-- 02_basic_hr_kpis.sql
-- Business question: what does the workforce look like, and what is the overall attrition?

-- Row count check
SELECT COUNT(*) AS total_employees
FROM employees;

-- Quick look at the data
SELECT *
FROM employees
LIMIT 5;

-- Overall attrition (count and %)
SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM employees
GROUP BY Attrition;

-- Average monthly income
SELECT ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM employees;

-- Headcount and attrition by department
SELECT
    Department,
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Department, Attrition
ORDER BY Department;
