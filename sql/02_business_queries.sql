-- 1. CUSTOMER RETENTION (30-DAY)

WITH first_order AS (
    SELECT user_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY user_id
),
second_order AS (
    SELECT o.user_id, MIN(o.order_date) AS second_order_date
    FROM orders o
    JOIN first_order f ON o.user_id = f.user_id
    WHERE o.order_date > f.first_order_date
    GROUP BY o.user_id
)
SELECT 
    COUNT(f.user_id) AS total_users,
    COUNT(s.user_id) AS retained_users,
    ROUND(COUNT(s.user_id) * 100.0 / COUNT(f.user_id), 2) AS retention_rate
FROM first_order f
LEFT JOIN second_order s 
ON f.user_id = s.user_id
AND s.second_order_date <= f.first_order_date + INTERVAL '30 days';



-- 2. REPEAT VS ONE-TIME CUSTOMERS

WITH user_orders AS (
    SELECT user_id,
           COUNT(order_id) AS total_orders,
           SUM(order_amount) AS total_revenue
    FROM orders
    GROUP BY user_id
)
SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(user_id) AS users_count,
    SUM(total_revenue) AS revenue
FROM user_orders
GROUP BY customer_type;



-- 3. REVENUE LEAKAGE DUE TO FAILED PAYMENTS

WITH order_payments AS (
    SELECT 
        o.order_id,
        o.order_amount,
        p.payment_status
    FROM orders o
    LEFT JOIN payments p 
    ON o.order_id = p.order_id
)
SELECT 
    SUM(order_amount) AS total_order_value,
    SUM(CASE WHEN payment_status = 'failed' THEN order_amount ELSE 0 END) AS failed_revenue
FROM order_payments;



-- 4. CUSTOMER LIFETIME VALUE (CLV)

SELECT 
    user_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    SUM(order_amount) AS lifetime_revenue
FROM orders
GROUP BY user_id;



-- 5. CHURNED CUSTOMERS (NO ORDER IN LAST 60 DAYS)

WITH last_order AS (
    SELECT user_id, MAX(order_date) AS last_order_date
    FROM orders
    GROUP BY user_id
)
SELECT 
    COUNT(user_id) AS churned_users
FROM last_order
WHERE last_order_date < CURRENT_DATE - INTERVAL '60 days';
