-- 01_table_creation.sql
-- Creates the employees table (IBM HR Analytics dataset + engineered columns).
-- Tested syntax: PostgreSQL (used in pgAdmin); also runs in SQLite and MySQL 8.
--
-- Raw columns 1-35 come from the public IBM dataset.
-- Columns 36-47 are engineered in the Excel workbook (flags, risk score, burnout, bands).
-- AttritionRiskScore = (OverTime*1.5 + LowJobSatis*2.5 + LowWLB*2 + LowSalary*1.5 + LowEnv*2 + NoPromotion5y*0.5) / 10
--   -> moves in steps of 0.05, so it needs DECIMAL(4,2) (DECIMAL(3,1) rounds it).
-- Burnout = (OverTime*4 + LowWLB*3 + LowJobSatis*2 + NoPromotion5y*1) / 10

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,

    -- engineered columns
    OverTimeFlag INT,
    LowJobSatisFlag INT,
    LowWLBFlag INT,
    LowSalaryFlag INT,
    LowEnviFlag INT,
    LowProFlag INT,

    AttritionRiskScore DECIMAL(4,2),
    AtriRiskCategory VARCHAR(20),

    Burnout DECIMAL(3,1),
    BurnoutLevel VARCHAR(30),

    StagnationLevel VARCHAR(30),
    SalaryBands VARCHAR(30)
);

-- Load the data (PostgreSQL, run from psql in the project folder):
-- \copy employees FROM '03_Data/employees.csv' WITH (FORMAT csv, HEADER true);
-- (pgAdmin: right-click the table -> Import/Export Data -> choose employees.csv, header on)
