-- USERS TABLE
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    city VARCHAR(50)
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2)
);

-- PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR(20),
    payment_date DATE
);
