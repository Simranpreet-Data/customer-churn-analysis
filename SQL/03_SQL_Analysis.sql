-- ====================================================================
-- Customer Churn Analysis
-- Phase 3: Business Analysis
-- Objective: Answer business question using SQL
-- ====================================================================
USE customer_churn;
-- ====================================================================
-- Business Question 1
-- What is overall churn rate?
-- ====================================================================
SELECT COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn;
-- ====================================================================
-- Business Question 2
-- Which contract type has the highest churn rate?
-- ====================================================================
SELECT contract, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;
-- ====================================================================
-- Business Question 3
-- Which tenure group has the highest churn rate?
-- ====================================================================
SELECT tenure_group, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;
-- ===================================================================
-- Business Question 4
-- Does monthly charge affect churn?
-- ===================================================================
SELECT monthly_charge_group, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY monthly_charge_group
ORDER BY churn_rate DESC;
-- ===================================================================
-- Business question 5
-- Which payment method has the highest churn rate?
-- ===================================================================
SELECT payment_method, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;
-- ====================================================================
-- Business Question 6
-- Which internet service has the highest churn rate?
-- ====================================================================
SELECT internet_service, COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END)*100.0/COUNT(*),2)
AS churn_rate
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate DESC;
-- ===================================================================
-- Business Question 7
-- Compare average monthly charges by churn status 
-- ===================================================================
SELECT churn,
ROUND(AVG(monthly_charges),2) AS average_monthly_charge
FROM customer_churn
GROUP BY churn;
-- ===================================================================
-- Business Question 8
-- Compare average tenure by churn status
-- ===================================================================
SELECT churn,
ROUND(AVG(tenure),2) AS average_tenure
FROM customer_churn
GROUP BY churn;