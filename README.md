#  Layoffs Data Cleaning Project (SQL)

#  Overview
This project focuses on cleaning and preparing a real-world layoffs dataset using SQL.  
The goal is to transform raw data into a clean, structured format suitable for analysis by handling duplicates, missing values, and inconsistent formatting.

---

##  Objectives
- Create a safe staging environment for data cleaning
- Identify and remove duplicate records
- Standardize inconsistent text and date formats
- Handle missing values in key fields
- Remove unnecessary columns after processing

---

# Tools Used
- MySQL
- SQL (CTE, Window Functions, Data Cleaning techniques)

---

#  Data Cleaning Process

### 1. Data Staging
- Created `layoff_staging` table from the raw `layoffs` dataset
- Duplicated data into a second staging table (`layoff_staging2`) for safe transformations

---

### 2. Removing Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicate rows
- Applied a CTE to isolate duplicates
- Removed duplicate records from the dataset

---

### 3. Data Standardization
- Used `TRIM()` to remove extra spaces from text fields
- Standardized values in `company`, `industry`, and `country`
- Cleaned trailing punctuation from country names
- Converted inconsistent date formats using `STR_TO_DATE()`
- Changed `date` column type from TEXT to DATE

---

### 4. Handling Missing Values (NULLs)
- Identified missing values in `industry`, `total_laid_off`, and `percentage_laid_off`
- Applied a selective approach:
  - Some NULL values were retained to preserve data integrity
  - Some were considered for imputation using related records (same company)
  - Rows with no reliable information were removed

---

### 5. Removing Unnecessary Data
- Deleted rows where both `total_laid_off` and `percentage_laid_off` were NULL
- Dropped helper column `row_num` after completing duplicate detection

---

##  Key SQL Concepts Used
- CTE (Common Table Expressions)
- Window Functions (ROW_NUMBER)
- Data Cleaning Functions (TRIM, STR_TO_DATE)
- Data Type Conversion (ALTER TABLE)
- Filtering and Conditional Deletion

---

##  Outcome
A clean, structured, and analysis-ready dataset with:
- No duplicate records
- Standardized text and date formats
- Improved data consistency
- Reduced noise from invalid or incomplete rows

---

##  Key Learnings
- Importance of staging tables in data workflows
- Practical use of SQL for real-world data cleaning
- How to handle duplicates using window functions
- Balancing between data removal and data retention
- Data quality decision-making (delete vs impute vs retain NULLs)

