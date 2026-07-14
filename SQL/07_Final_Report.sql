-- =========================================================================================================
-- Customer Churn Analysis
-- Phase 8: Executive Final Report
-- Objective: Executive-Level SQL Report
-- =========================================================================================================
USE customer_churn;
-- =========================================================================================================
-- Query 1: Overall Churn Rate
-- =========================================================================================================

SELECT
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate
FROM customer_churn;

-- ==========================================================================================================
-- Query 2: Churn by Contract Type
-- ==========================================================================================================

SELECT
contract,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;

-- ==========================================================================================================
-- Query 3: Churn by Payment Method
-- ==========================================================================================================

SELECT payment_method,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;

-- =======================================================================================================
-- Query 4: Revenue at Risk
-- Monthly Revenue from Customers Who Churned
-- =======================================================================================================

SELECT ROUND(SUM(monthly_charges), 2) AS monthly_revenue_at_risk
FROM customer_churn
WHERE churn = 'Yes';

-- =======================================================================================================
-- Query 5: Top 10 Customers by Total Charges
-- =======================================================================================================

SELECT customer_id, contract, tenure, total_charges
FROM customer_churn
ORDER BY total_charges DESC
LIMIT 10;

-- ======================================================================================================
-- Query 6: Average Tenure by Churn Status
-- ======================================================================================================

SELECT churn,
ROUND(AVG(tenure), 2) AS average_tenure
FROM customer_churn
GROUP BY churn;

-- ========================================================================================================
-- Query 7: High-Value Customers at Risk
-- Customers with above-average total charges who churned
-- ========================================================================================================

SELECT customer_id, contract, monthly_charges, total_charges
FROM customer_churn
WHERE churn = 'Yes'
AND total_charges >
(
SELECT AVG(total_charges) FROM customer_churn
)
ORDER BY total_charges DESC;

-- =========================================================================================================
-- Query 8: Churn by Internet Service
-- =========================================================================================================

SELECT
internet_service, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate DESC;

-- ===========================================================================================================
-- Query 9: Churn by Tenure Group
-- ===========================================================================================================

SELECT
tenure, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY tenure
ORDER BY churn_rate DESC;

-- ==========================================================================================================
-- Query 10: Executive KPI Summary
-- ==========================================================================================================

SELECT
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate,
ROUND(AVG(monthly_charges), 2) AS average_monthly_charges,
ROUND(SUM(total_charges), 2) AS total_monthly_revenue,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN monthly_charges ELSE 0 END), 2) AS revenue_at_risk
FROM customer_churn;