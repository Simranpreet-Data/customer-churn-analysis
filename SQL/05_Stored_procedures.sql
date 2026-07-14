-- ==========================================
-- Customer Churn Analysis
--  Phase 5: Stored Procedures
-- Objective: Automate Common Business Reports
-- ==========================================
USE customer_churn;
-- ==========================================
-- Procedure 1: Overall Churn Summary
-- ==========================================
DELIMITER $$

CREATE PROCEDURE overall_churn_summary()
BEGIN
SELECT
COUNT(*) AS total_customers,
SUM(CASE
WHEN churn = 'Yes' THEN 1 ELSE 0
END) AS churned_customers,
SUM(CASE WHEN churn = 'No' THEN 1
ELSE 0 END) AS active_customers,
ROUND(SUM(CASE
WHEN churn = 'Yes' THEN 1
ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn;
END $$

DELIMITER ;
-- Run the procedure
CALL overall_churn_summary();

-- ==========================================
-- Procedure 2: Churn by Contract
-- ==========================================

DELIMITER $$

CREATE PROCEDURE churn_by_contract()
BEGIN
SELECT
contract,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE
WHEN churn = 'Yes' THEN 1
ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;
END $$

DELIMITER ;
-- Run the procedure
CALL churn_by_contract();

-- ==========================================
-- Procedure 3: Churn by Payment Method
-- ==========================================

DELIMITER $$

CREATE PROCEDURE churn_by_payment_method()
BEGIN
SELECT
payment_method,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1
ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;
END $$

DELIMITER ;
-- Run the procedure
CALL churn_by_payment_method();