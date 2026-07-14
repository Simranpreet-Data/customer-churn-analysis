-- ====================================================================
-- Customer churn Analysis
-- Phase 6: Advanced SQL
-- Objective: Practice CTEs and Window Functions
-- =====================================================================
Use customer_churn;
-- =====================================================================
-- Query 1: CTE- Customers with Above Average Monthly Charges
-- =====================================================================

WITH avg_monthly_charge AS 
(
SELECT AVG(monthly_charges) AS avg_charge
FROM customer_churn
)
SELECT
customer_id, monthly_charges
FROM customer_churn
WHERE monthly_charges >
(
SELECT avg_charge
FROM avg_monthly_charge
);

-- ======================================================================
-- Query 2: Rank Customers by Monthly Charges
-- Using ROW_NUMBER()
-- ======================================================================

SELECT
customer_id, monthly_charges,
ROW_NUMBER() OVER (ORDER BY monthly_charges DESC) AS row_number_rank
FROM customer_churn;

-- ======================================================================
-- Query 3: Rank Customers by Monthly Charges
-- Using RANK()
-- ======================================================================

SELECT
customer_id, monthly_charges,
RANK() OVER (ORDER BY monthly_charges DESC) AS customer_rank
FROM customer_churn;

-- ======================================================================
-- Query 4: Rank Customers by Monthly Charges
-- Using DENSE_RANK()
-- ======================================================================

SELECT
customer_id, monthly_charges,
DENSE_RANK() OVER (ORDER BY monthly_charges DESC) AS dense_customer_rank
FROM customer_churn;

-- ======================================================================
-- Query 5: Top 5 Highest Paying Customers
-- ======================================================================

SELECT * FROM
(
SELECT
customer_id,
monthly_charges,
ROW_NUMBER() OVER (ORDER BY monthly_charges DESC) AS row_num
FROM customer_churn
) as ranked
WHERE row_num <= 5;

-- =====================================================================
-- Query 6: Running Total of Monthly Charges
-- =====================================================================

SELECT
customer_id,
monthly_charges,
ROUND(SUM(monthly_charges)
OVER (ORDER BY customer_id),2) AS running_total
FROM customer_churn;

-- =====================================================================
-- Query 7: Average Monthly Charges by Contract
-- =====================================================================

SELECT
customer_id, contract, monthly_charges,
ROUND(AVG(monthly_charges) OVER (PARTITION BY contract),2)
AS contract_average
FROM customer_churn;

-- ====================================================================
-- Query 8: Rank Customers Within Each Contract
-- ====================================================================

SELECT
customer_id, contract, monthly_charges,
RANK() OVER
(PARTITION BY contract ORDER BY monthly_charges DESC) AS contract_rank
FROM customer_churn;