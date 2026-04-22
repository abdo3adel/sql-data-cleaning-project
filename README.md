# SQL Data Cleaning Project – Layoffs Dataset

# Overview
This project focuses on cleaning and preparing a layoffs dataset using SQL.  
The goal is to ensure data quality, consistency, and reliability for further analysis.

---

# Objectives
- Clean raw layoffs data
- Remove duplicates
- Handle missing values (NULLs)
- Standardize text fields
- Convert data types for proper analysis

---
# Tools Used
- MySQL
- SQL (CTE, Window Functions, Data Cleaning techniques)
---

## 🔄 Workflow Steps

### 1. Data Staging
- Created `layoff_staging` table from raw dataset
- Preserved original data to avoid direct modifications

### 2. Duplicate Handling
- Created `layoff_staging2` table with helper column (`row_num`)
- Used `ROW_NUMBER()` with CTE to identify duplicate records
- Removed duplicate rows successfully

### 3. Handling Missing Values
- Identified NULL values in key columns (industry, total_laid_off, percentage_laid_off)
- Removed rows where both `total_laid_off` and `percentage_laid_off` were NULL due to insufficient data

### 4. Data Cleaning & Standardization
- Used `TRIM()` to remove extra spaces
- Cleaned trailing characters from text fields
- Standardized inconsistent values

### 5. Date Formatting
- Converted `date` column from TEXT to proper DATE format using `STR_TO_DATE()`
- Updated column type to DATE for accurate time-based analysis

### 6. Final Cleanup
- Removed helper column (`row_num`) after completing deduplication process

---

##  Key SQL Concepts Used
- CTE (Common Table Expressions)
- Window Functions (ROW_NUMBER)
- String Functions (TRIM)
- Date Functions (STR_TO_DATE)
- Data Type Conversion (ALTER TABLE)
- Data Cleaning Best Practices

---

##  Outcome
A clean and structured dataset ready for analysis and visualization, free from duplicates, inconsistent formats, and invalid data entries.

---

##  What I Learned
- Real-world data is messy and requires structured cleaning
- Importance of staging tables in data workflows
- How to handle duplicates and missing values properly
- Practical use of SQL for data preprocessing

---

## 📁 Project Structure
