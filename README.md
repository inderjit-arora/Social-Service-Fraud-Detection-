
Social Service Fraud Detection Project

Overview

This project aims to detect potential fraudulent activities within the Social Service Department. The goal is to analyze and identify suspicious behaviors such as:

Same-day bank account changes and high-risk payments (e.g., urgent, advance, disaster, one-off).

Beneficiaries changing their bank accounts more than twice in a year.

Flagging suspicious transactions for further investigation.

By utilizing SQL queries and data analysis techniques, we model and analyze data to uncover patterns that could indicate fraud.



Technologies Used


 
MySQL: For creating the database schema and running queries to detect potential fraud.

Python: Used for generating synthetic data (randomized data), and for querying the MySQL database.

Pandas: For handling and manipulating data.




Step 1: Database Setup
Create MySQL Database:

First, create a new MySQL database with the following command:
CREATE DATABASE social_service_fraud;
USE social_service_fraud;

Create Tables:

In MySQL database, create the following tables to store data on beneficiaries, bank account changes, and payments.

The tables will track beneficiaries' details, payment types, and any changes to their bank accounts.


Step 2: Generate Random Data (Optional)

Run the provided Python script to generate random data for 1000 beneficiaries, their bank account changes, and payments. This will create three CSV files:

beneficiaries.csv: Contains basic beneficiary data.

bank_account_changes.csv: Tracks changes to beneficiaries' bank accounts.

payments.csv: Records the payments made to beneficiaries.

After generating the data, you will need to manually load these CSV files into the appropriate MySQL tables.


Step 3: Run Fraud Detection Queries
Once the data is loaded into MySQL, use the SQL queries provided in the fraud_detection.sql file. These queries will help you detect potential fraudulent activities based on the following conditions:

Same-day payments and bank account changes.

Multiple bank account changes by a beneficiary within a year.

Fraud detection combining both conditions.


Step 4: Flagged Transactions Analysis
After running the fraud detection queries, review the flagged transactions. These transactions will be identified based on the following criteria:

Beneficiaries who change their bank accounts more than twice in a year.

Transactions where payments are made on the same day as a bank account change, and those payments are categorized as "urgent," "advance," "disaster," or "one-off."

Flagged transactions will be stored for further investigation or reporting.

 
 Data Analysis Logic
 
1. Data Modeling (MySQL Schema)
   
Beneficiaries Table: Stores information about each beneficiary, including their personal details.

Bank Account Changes Table: Keeps track of any bank account changes for each beneficiary.

Payments Table: Contains records of all payments made to beneficiaries, including payment types and amounts.

2. Data Engineering
Clean and preprocess data for analysis.

Detect anomalies and patterns indicative of fraud using SQL queries.

Perform checks for conditions like same-day account changes and multiple changes within a year.

3. Data Analysis
Analyze transactions for suspicious patterns:

Flag transactions where high-risk payments (e.g., urgent, advance, disaster, one-off) are made on the same day as a bank account change.

Flag beneficiaries who change their bank accounts more than twice in a year as potentially fraudulent.
