-- ==========================================================================
-- Customer Churn Analysis
-- Phase 2: Data Preparation
-- Objective: Create helper columns for business analysis
-- ==========================================================================
USE customer_churn;

-- ==========================================================================
-- Step 1: Add Tenure Group
-- Purpose: Group customers based on how long they have stayed
-- ==========================================================================
ALTER TABLE customer_churn
ADD COLUMN tenure_group VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE customer_churn
SET tenure_group = 
CASE WHEN tenure <= 12 THEN '0-12 Months'
WHEN tenure <= 24 THEN '13-24 Months'
WHEN tenure <= 48 THEN '25-48 Months'
ELSE '49-72 Months'
END;

SELECT tenure, tenure_group
FROM customer_churn
limit 20;

-- ===============================================================================
-- Step 2: Add Monthly Charge Group
-- Purpose: Segement customers based on monthly bill
-- ==============================================================================
ALTER TABLE customer_churn
ADD COLUMN monthly_charge_group VARCHAR(20);

UPDATE customer_churn
SET monthly_charge_group = 
CASE WHEN monthly_charges < 35 THEN 'Low'
WHEN monthly_charges < 70 THEN 'Medium'
ELSE 'High'
END;

SELECT monthly_charges, monthly_charge_group FROM
customer_churn
LIMIT 20;

-- ==================================================================================
-- Step 3: Add Customer Status
-- Purpose: Make churn values easier to understand
-- =================================================================================
ALTER TABLE customer_churn
ADD COLUMN customer_status VARCHAR(20);

UPDATE customer_churn
SET customer_status = 
CASE WHEN churn = 'Yes' THEN 'Churned'
ELSE 'Active'
END;

SELECT churn, customer_status
FROM customer_churn
LIMIT 20;

-- ================================================================================
-- Step 4: Validate new columns
-- ================================================================================
DESCRIBE customer_churn;

SELECT * FROM 
customer_churn
LIMIT 10;
-- =================================================================================
-- Data Preparation Summary
-- =================================================================================
-- 1.) Created tenure_group.
-- 2.) Created monthly_charge_group.
-- 3.) Created customer_status.
-- 4.) Verified helper columns.