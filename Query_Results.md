# Query Results

Results of running every script in `02_SQL/` (in order) on `03_Data/employees.csv` (1,470 employees). Results with more than 12 rows (employee lists and rankings) are not shown here; run the script to see them.


## 01_table_creation.sql


## 02_basic_hr_kpis.sql

**Business question: what does the workforce look like, and what is the overall attrition?**

|   total_employees |
|------------------:|
|              1470 |

**Overall attrition (count and %)**

| Attrition   |   employee_count |   percentage |
|:------------|-----------------:|-------------:|
| No          |             1233 |        83.88 |
| Yes         |              237 |        16.12 |

**Average monthly income**

|   avg_income |
|-------------:|
|      6502.93 |

**Headcount and attrition by department**

| Department             | Attrition   |   employee_count |
|:-----------------------|:------------|-----------------:|
| Human Resources        | No          |               51 |
| Human Resources        | Yes         |               12 |
| Research & Development | No          |              828 |
| Research & Development | Yes         |              133 |
| Sales                  | No          |              354 |
| Sales                  | Yes         |               92 |


## 03_attrition_analysis.sql

**3.1 Attrition rate by department (CTE)**

| Department             |   total_employees |   attrition_count |   attrition_rate |
|:-----------------------|------------------:|------------------:|-----------------:|
| Sales                  |               446 |                92 |            20.63 |
| Human Resources        |                63 |                12 |            19.05 |
| Research & Development |               961 |               133 |            13.84 |

**3.2 Attrition by overtime (share within each overtime group)**

| OverTime   | Attrition   |   employee_count |   percentage |
|:-----------|:------------|-----------------:|-------------:|
| No         | No          |              944 |        89.56 |
| No         | Yes         |              110 |        10.44 |
| Yes        | No          |              289 |        69.47 |
| Yes        | Yes         |              127 |        30.53 |

**3.3 Attrition by tenure stage (retention cohorts)**

| tenure_cohort   |   total_employees |   attrition_count |   attrition_rate |
|:----------------|------------------:|------------------:|-----------------:|
| 0-2 Years       |               215 |                75 |            34.88 |
| 2-5 Years       |               561 |                87 |            15.51 |
| 6-10 Years      |               448 |                55 |            12.28 |
| 10+ Years       |               246 |                20 |             8.13 |

**3.4 Is overtime a department effect or an individual effect?**

| Department             |   total_employees |   attrition_rate |   overtime_rate |   avg_burnout |
|:-----------------------|------------------:|-----------------:|----------------:|--------------:|
| Sales                  |               446 |            20.63 |           28.7  |          0.29 |
| Human Resources        |                63 |            19.05 |           26.98 |          0.27 |
| Research & Development |               961 |            13.84 |           28.2  |          0.3  |

**Attrition with vs without overtime, inside each department**

| Department             | OverTime   |   total_employees |   attrition_rate |
|:-----------------------|:-----------|------------------:|-----------------:|
| Human Resources        | No         |                46 |            15.22 |
| Human Resources        | Yes        |                17 |            29.41 |
| Research & Development | No         |               690 |             8.55 |
| Research & Development | Yes        |               271 |            27.31 |
| Sales                  | No         |               318 |            13.84 |
| Sales                  | Yes        |               128 |            37.5  |


## 04_burnout_analysis.sql

**4.1 Burnout level distribution with attrition rate and average risk score**

| BurnoutLevel   |   employees |   attrition_rate |   avg_risk_score |
|:---------------|------------:|-----------------:|-----------------:|
| High Burnout   |         147 |            31.29 |             0.61 |
| Medium Burnout |         412 |            25.49 |             0.47 |
| Low Burnout    |         911 |             9.44 |             0.31 |

**4.2 Burnout level by department (heatmap input)**

| Department             | BurnoutLevel   |   employees |
|:-----------------------|:---------------|------------:|
| Human Resources        | High Burnout   |           2 |
| Human Resources        | Low Burnout    |          42 |
| Human Resources        | Medium Burnout |          19 |
| Research & Development | High Burnout   |         102 |
| Research & Development | Low Burnout    |         588 |
| Research & Development | Medium Burnout |         271 |
| Sales                  | High Burnout   |          43 |
| Sales                  | Low Burnout    |         281 |
| Sales                  | Medium Burnout |         122 |


## 05_salary_risk_and_promotion.sql

**5.1 Salary bands: size, pay, risk score and actual attrition**

| SalaryBands   |   employees |   avg_salary |   avg_risk |   attrition_rate |
|:--------------|------------:|-------------:|-----------:|-----------------:|
| Low Salary    |         542 |         2694 |       0.43 |            25.28 |
| Medium Salary |         547 |         5524 |       0.4  |            10.97 |
| High Salary   |         381 |        13327 |       0.29 |            10.5  |

**5.3 Does the risk score separate leavers from stayers? (score bands decided in advance)**

| risk_band                |   employees |   leavers |   attrition_rate |
|:-------------------------|------------:|----------:|-----------------:|
| 1. Low (below 0.30)      |         453 |        31 |             6.84 |
| 2. Medium (0.30 to 0.59) |         736 |       126 |            17.12 |
| 3. High (0.60 and above) |         281 |        80 |            28.47 |

**5.4 Promotion stagnation level vs attrition**

| StagnationLevel   |   employees |   avg_years_without_promotion |   attrition_rate |
|:------------------|------------:|------------------------------:|-----------------:|
| High Stagnation   |         260 |                          8.23 |            14.23 |
| Medium Stagnation |         113 |                          3.54 |            12.39 |
| Low Stagnation    |        1097 |                          0.62 |            16.96 |

**5.5 Does delayed promotion increase attrition?**

| Attrition   |   avg_promotion_gap |   avg_risk_score |
|:------------|--------------------:|-----------------:|
| No          |                2.23 |             0.36 |
| Yes         |                1.95 |             0.49 |


## 06_window_functions.sql


## 07_views_and_workforce_structure.sql

**Use the views**

| Department             |   total_employees |   avg_salary |   avg_burnout |   avg_risk_score |   attrition_rate |
|:-----------------------|------------------:|-------------:|--------------:|-----------------:|-----------------:|
| Sales                  |               446 |      6959.17 |          0.29 |             0.37 |            20.63 |
| Human Resources        |                63 |      6654.51 |          0.27 |             0.39 |            19.05 |
| Research & Development |               961 |      6281.25 |          0.3  |             0.39 |            13.84 |

**Number of high-risk employees (score 0.7 or higher)**

|   high_risk_count |
|------------------:|
|               116 |

**Workforce distribution by department and gender**

| Department             | Gender   |   total_employees |   gender_percentage |
|:-----------------------|:---------|------------------:|--------------------:|
| Human Resources        | Female   |                20 |               31.75 |
| Human Resources        | Male     |                43 |               68.25 |
| Research & Development | Female   |               379 |               39.44 |
| Research & Development | Male     |               582 |               60.56 |
| Sales                  | Female   |               189 |               42.38 |
| Sales                  | Male     |               257 |               57.62 |
