Customer Retention & Revenue Performance Analysis (SQL Project)
📖 Business Problem

The company observed stagnant revenue growth despite increasing user sign-ups.
This project analyzes customer retention, churn behavior, repeat purchases, and revenue leakage using SQL to provide actionable business insights.

Objectives
Measure customer retention using cohort analysis
Identify churned users and revenue loss
Analyze repeat vs one-time customer contribution
Detect revenue leakage due to failed payments
Estimate Customer Lifetime Value (CLV)
Identify high-value customers using Pareto principle

Dataset Structure
users
    user_id
    signup_date
    city
orders
    order_id
    user_id
    order_date
    order_amount
payments
    payment_id
    order_id
    payment_status
    payment_date

SQL Concepts Used

CTEs (WITH clause)
Window functions
Date arithmetic
Aggregations
Business logic modeling

Key Insights
Repeat customers contribute majority of revenue
Payment failures cause measurable revenue leakage
A small percentage of users generate most of the revenue
Early retention is critical for long-term value

📌 This project simulates real-world business analysis performed by data analysts in product-based companies.
