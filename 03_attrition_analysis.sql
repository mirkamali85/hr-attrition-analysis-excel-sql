-- 03_attrition_analysis.sql
-- Business question: who leaves, and where is attrition concentrated?

-- 3.1 Attrition rate by department (CTE)
WITH dept_attrition AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
    FROM employees
    GROUP BY Department
)
SELECT
    Department,
    total_employees,
    attrition_count,
    ROUND(attrition_count * 100.0 / total_employees, 2) AS attrition_rate
FROM dept_attrition
ORDER BY attrition_rate DESC;

-- 3.2 Attrition by overtime (share within each overtime group)
SELECT
    OverTime,
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY OverTime), 2) AS percentage
FROM employees
GROUP BY OverTime, Attrition
ORDER BY OverTime, Attrition;

-- 3.3 Attrition by tenure stage (retention cohorts)
WITH cohorts AS (
    SELECT
        EmployeeNumber,
        Attrition,
        CASE
            WHEN YearsAtCompany < 2 THEN '0-2 Years'
            WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 Years'
            WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
            ELSE '10+ Years'
        END AS tenure_cohort
    FROM employees
)
SELECT
    tenure_cohort,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM cohorts
GROUP BY tenure_cohort
ORDER BY attrition_rate DESC;

-- 3.4 Is overtime a department effect or an individual effect?
-- Overtime rate per department vs attrition WITH and WITHOUT overtime inside each department.
-- (Added when re-checking the department-level overtime claim; see 06_Insights/attrition_insights.md)
WITH dept_base AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
        SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) AS overtime_count,
        AVG(Burnout) AS avg_burnout
    FROM employees
    GROUP BY Department
)
SELECT
    Department,
    total_employees,
    ROUND(attrition_count * 100.0 / total_employees, 2) AS attrition_rate,
    ROUND(overtime_count * 100.0 / total_employees, 2) AS overtime_rate,
    ROUND(avg_burnout, 2) AS avg_burnout
FROM dept_base
ORDER BY attrition_rate DESC;

SELECT
    Department,
    OverTime,
    COUNT(*) AS total_employees,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY Department, OverTime
ORDER BY Department, OverTime;
