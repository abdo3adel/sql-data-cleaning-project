SELECT *
FROM layoffs;

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT*
FROM layoff_staging;

INSERT layoff_staging
SELECT* 
FROM layoffs;

-- 1- Remove Dublicate

SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging;

WITH dublicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging
)

SELECT *
FROM dublicate_cte
WHERE row_num > 1;

SELECT * 
FROM layoff_staging
WHERE company = 'Oyster';

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging;

DELETE FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

-- Note
-- Created a staging table (layoff_staging) from the raw dataset to carry out data cleaning while preserving the original data. 
-- Subsequently, created another table (layoff_staging2) to introduce an auxiliary column used for detecting duplicate records.
-- Used ROW_NUMBER() to detect duplicate rows and leveraged a CTE to streamline the deduplication process.

 -- 2- Standardize the data --

SELECT DISTINCT company
FROM layoff_staging2;

UPDATE layoff_staging2 
SET company = TRIM(company);

SELECT DISTINCT  industry
FROM layoff_staging2
ORDER BY 1;
 
SELECT DISTINCT  country
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2 
SET company = TRIM(industry);

SELECT DISTINCT  country , TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoff_staging2;

SELECT `date`,STR_TO_DATE(`date`, '%m/%d/%y')
FROM layoff_staging2;

UPDATE layoff_staging2 SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoff_staging2;

-- Note:
-- Leveraged DISTINCT on key columns (company, industry, country) to explore unique values 
-- and identify data inconsistencies such as duplicated entries with formatting differences.
-- Cleaned text fields using TRIM() functions to remove extra spaces and trailing punctuation.
-- Standardized date values by converting them from string format using STR_TO_DATE().
-- Updated the column data type from TEXT to DATE to ensure consistency and support date-based operations.

-- 3- figuring out NULLs -- 

SELECT *
FROM layoff_staging2
WHERE industry IS NULL
OR industry = '';

SELECT * 
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT * 
FROM layoff_staging2
WHERE company = 'Bally''s Interactive';

-- NOTE 
-- Tried to impute missing values in the industry column by leveraging existing industry data from other records of the same company.
-- In cases where no reliable reference was available, a JOIN-based approach would be applied to infer and populate the missing values.

--  Removing unnecessary columns 

SELECT * 
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoff_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoff_staging2;

ALTER TABLE layoff_staging2
DROP COLUMN row_num
-- Note:
--  Rows where both total_laid_off and percentage_laid_off are NULL were removed due to insufficient data to reliably impute these values.
-- Removed the row_num column after completing the duplicate detection process, as it was no longer needed.

