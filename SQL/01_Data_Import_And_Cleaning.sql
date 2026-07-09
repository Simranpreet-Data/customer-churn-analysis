-- ==================================================================================
-- Customer Churn Analysis
-- Phase 1: Data Import & Cleaning
-- Objective: Prepare the dataset for analysis
-- ==================================================================================
-- Step 1: Select the database
USE customer_churn;

-- Step 2: View available tables
SHOW TABLES;

-- Step 3: Check columns names and data types
DESCRIBE customer_churn;

-- Step 4: Preview the first 10 rows
SELECT * 
FROM customer_churn 
LIMIT 10;

-- Step 5 : Rename columns for consistency
ALTER TABLE customer_churn
RENAME COLUMN ï»¿customerID TO customer_id;
ALTER TABLE customer_churn
RENAME COLUMN SeniorCitizen TO senior_citizen;	
ALTER TABLE customer_churn
RENAME COLUMN Partner TO partner;	
ALTER TABLE customer_churn
RENAME COLUMN Dependents TO dependents;	
ALTER TABLE customer_churn
RENAME COLUMN PhoneService TO phone_service;
ALTER TABLE customer_churn
RENAME COLUMN MultipleLines TO multiple_lines;	
ALTER TABLE customer_churn
RENAME COLUMN InternetService TO internet_service;
ALTER TABLE customer_churn
RENAME COLUMN OnlineSecurity TO online_security;	
ALTER TABLE customer_churn
RENAME COLUMN OnlineBackup TO online_backup;	
ALTER TABLE customer_churn
RENAME COLUMN DeviceProtection TO device_protection;
ALTER TABLE customer_churn
RENAME COLUMN TechSupport TO tech_support;
ALTER TABLE customer_churn
RENAME COLUMN StreamingTV TO streaming_tv;
ALTER TABLE customer_churn
RENAME COLUMN StreamingMovies TO streaming_movies;
ALTER TABLE customer_churn
RENAME COLUMN Contract TO contract;	
ALTER TABLE customer_churn
RENAME COLUMN PaperlessBilling TO paperless_billing;
ALTER TABLE customer_churn
RENAME COLUMN PaymentMethod TO payment_method;
ALTER TABLE customer_churn
RENAME COLUMN MonthlyCharges TO monthly_charges;
ALTER TABLE customer_churn
RENAME COLUMN TotalCharges TO total_charges;
ALTER TABLE customer_churn
RENAME COLUMN Churn TO churn;

-- Step 6: Find duplicate customer IDs
SELECT customer_id, COUNT(*) as duplicate_count
FROM customer_churn
GROUP BY customer_id HAVING COUNT(*) > 1;

-- Step 7 : Check blank values in total_charges
SELECT COUNT(*) as blank_total_charges 
FROM customer_churn
WHERE TRIM(total_charges) = '';

-- Step 9 : Display records with blank total_charges
SELECT customer_id, tenure, total_charges
FROM customer_churn 
WHERE TRIM(total_charges) = '';

SET SQL_SAFE_UPDATES = 1;

-- Step 10 : Replace blank spaces with NULL
UPDATE customer_churn
SET total_charges = NULL
WHERE TRIM(total_charges) = '';

-- Step 11 : Verify NULL values
SELECT COUNT(*) AS null_total_charges FROM customer_churn
WHERE total_charges IS NULL;

-- Step 12 : Change data type
ALTER TABLE customer_churn
MODIFY COLUMN total_charges DOUBLE;

-- Step 13 : Review final data types
DESCRIBE customer_churn;

-- Step 14: Final validation
SELECT count(*) as total_customers
FROM customer_churn;

SELECT MIN(tenure) AS minimum_tenure,
MAX(tenure) AS maximum_tenure
FROM customer_churn;

SELECT * FROM customer_churn
LIMIT 10;

-- ====================================================================================
-- Data Cleaning Notes
-- ====================================================================================
-- 1.) Verified the total number of records.
-- 2.) Checked for duplicate Customer IDs.
-- 3.) Identified blank values in total_charges.
-- 4.) Replaced blank spaces with NULL.
-- 5.) Converted total_charges from Text to Double.
-- 6.) Validated the cleaned dataset before analysis