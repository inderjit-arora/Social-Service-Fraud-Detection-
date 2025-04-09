#Data Modeling (MySQL Schema)

CREATE DATABASE IF NOT EXISTS social_service_fraud;
USE social_service_fraud;

-- Beneficiaries Table
CREATE TABLE beneficiaries (
    beneficiary_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    address VARCHAR(255)
);

-- Bank Account Changes Table
CREATE TABLE bank_account_changes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    beneficiary_id INT,
    change_date DATE,
    new_bank_account VARCHAR(50),
    FOREIGN KEY (beneficiary_id) REFERENCES beneficiaries(beneficiary_id)
);

-- Payments Table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    beneficiary_id INT,
    payment_date DATE,
    payment_type VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (beneficiary_id) REFERENCES beneficiaries(beneficiary_id)
);
#Data Engineering: Clean and Prepare Data
#Count Bank Account Changes Per Beneficiary in 2023

CREATE TEMPORARY TABLE bank_change_count AS
SELECT beneficiary_id, COUNT(*) AS change_count
FROM bank_account_changes
WHERE YEAR(change_date) = 2023
GROUP BY beneficiary_id;

#Data Analysis: Fraud Detection Rules
#Rule 1: Same Day Payment & Account Change (and high-risk payment)

SELECT 
    p.beneficiary_id,
    p.payment_date,
    p.payment_type,
    p.amount,
    b.change_date,
    CASE 
        WHEN p.payment_date = b.change_date 
             AND p.payment_type IN ('urgent', 'advance', 'disaster', 'one_off') 
        THEN 1 ELSE 0 
    END AS same_day_flag
FROM payments p
JOIN bank_account_changes b 
    ON p.beneficiary_id = b.beneficiary_id;

# Rule 2: More than 2 Bank Changes in a Year #

SELECT beneficiary_id
FROM bank_change_count
WHERE change_count > 2;

# Rule 3: Combine Both Fraud Conditions #

SELECT 
    p.beneficiary_id,
    p.payment_date,
    p.payment_type,
    p.amount,
    b.change_date,
    CASE 
        WHEN p.payment_date = b.change_date 
             AND p.payment_type IN ('urgent', 'advance', 'disaster', 'one_off') 
        THEN 1 ELSE 0 
    END AS same_day_flag,
    CASE 
        WHEN bc.change_count > 2 THEN 1 ELSE 0 
    END AS multi_change_flag,
    CASE 
        WHEN (p.payment_date = b.change_date AND p.payment_type IN ('urgent', 'advance', 'disaster', 'one_off')) 
              OR bc.change_count > 2 
        THEN 1 ELSE 0 
    END AS final_fraud_flag
FROM payments p
LEFT JOIN bank_account_changes b 
    ON p.beneficiary_id = b.beneficiary_id
LEFT JOIN bank_change_count bc 
    ON p.beneficiary_id = bc.beneficiary_id;