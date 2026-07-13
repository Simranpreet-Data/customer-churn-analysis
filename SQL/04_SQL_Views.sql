-- ====================================================================
-- Customer Churn Analysis
-- Phase 4: SQL Views
-- Objective: Create reusable views for reporting
-- ====================================================================
USE customer_churn;
-- ====================================================================
-- View1: Customer Summary
-- Purpose: Basic customer information for reporting
-- ===================================================================
CREATE VIEW customer_summary AS
SELECT
customer_id, gender, senior_citizen, partner,
dependents, tenure, tenure_group, contract, payment_method,
internet_service, monthly_charges, total_charges, churn,
customer_status
FROM customer_churn;
-- Test View
SELECT * FROM customer_summary
LIMIT 10;
-- =====================================================================
-- View 2: Churn summary
-- Purpose: Show only customers who churned
-- ======================================================================
CREATE VIEW churn_summary AS
SELECT
customer_id, tenure, tenure_group, contract, payment_method,
internet_service, monthly_charges, total_charges
FROM customer_churn
WHERE churn = 'Yes';
-- Test View
SELECT * FROM churn_summary
LIMIT 10;
-- ======================================================================
-- View 3: Revenue Summary
-- Purpose: Revenue by contract type
-- ======================================================================
CREATE VIEW revenue_summary AS
SELECT contract,
COUNT(*) AS total_customers,
ROUND(SUM(monthly_charges),2) AS total_monthly_revenue,
ROUND(AVG(monthly_charges),2) AS average_monthly_charge
FROM customer_churn
GROUP BY contract;
-- Test View
SELECT * 
FROM revenue_summary;
-- =====================================================================
-- View 4: Churn Rate by Contract
-- Purpose: Dashboard-ready churn report
-- =====================================================================
CREATE VIEW churn_rate_by_contract AS
SELECT contract,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY contract;
-- Test View
SELECT * FROM churn_rate_by_contract;


