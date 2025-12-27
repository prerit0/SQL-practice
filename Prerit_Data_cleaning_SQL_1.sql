create database dc;
use dc;

select * from customer_orders
limit 10;

-- Formatting first_name column
SELECT
  first_name,
  TRIM(first_name) AS step1_trimmed,
  UPPER(TRIM(first_name)) AS cleaned_first_name
FROM customer_orders;

-- Formatting last_name column
SELECT
  last_name,
  UPPER(TRIM(last_name)) AS cleaned_last_name
FROM customer_orders;

-- Concatinating first_name and last_name columns
SELECT
  CONCAT(
    UPPER(TRIM(first_name)),
    ' ',
    UPPER(TRIM(last_name))
  ) AS full_name
FROM customer_orders;

-- Cleaning email column
SELECT
  email,
  LOWER(email) AS cleaned_email
FROM customer_orders;

-- Cleaning mobile_number column
SELECT
  mobile_number,
  SUBSTR(mobile_number, LENGTH(mobile_number) - 9, 10) AS cleaned_mobile
FROM customer_orders;

-- Extracting year from order_id column
SELECT
  order_id,
  SUBSTR(order_id, 5, 4) AS order_year
FROM customer_orders;

-- Rounding order_amount
SELECT
  order_amount,
  ROUND(order_amount, 2) AS cleaned_order_amount
FROM customer_orders;

-- Rounding rating
SELECT
  rating,
  ROUND(rating, 1) AS cleaned_rating
FROM customer_orders;

-- Standadizing city
SELECT
  city,
  UPPER(city) AS cleaned_city
FROM customer_orders;

-- Delivery time calculation
SELECT
  order_date,
  delivery_date,
  DATEDIFF(delivery_date, order_date) AS delivery_days
FROM customer_orders;

-- customer tenure calculation 
SELECT
  signup_date,
  DATEDIFF(NOW(), signup_date) AS days_with_company
FROM customer_orders;

-- Dividing order_amount categorically 
SELECT
  order_amount,
  CASE
    WHEN order_amount >= 50000 THEN 'High Value'
    WHEN order_amount >= 20000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS order_category
FROM customer_orders;

-- Dividing customer categorically 
SELECT
  signup_date,
  CASE
    WHEN DATEDIFF(NOW(), signup_date) <= 30 THEN 'New'
    WHEN DATEDIFF(NOW(), signup_date) <= 180 THEN 'Regular'
    ELSE 'Loyal'
  END AS customer_type
FROM customer_orders;

-- creating view as new dataframe
CREATE VIEW customer_orders_cleaned AS
SELECT
  customer_id,
  UPPER(TRIM(first_name)) AS first_name,
  UPPER(TRIM(last_name)) AS last_name,
  CONCAT(
    UPPER(TRIM(first_name)), ' ',
    UPPER(TRIM(last_name))
  ) AS full_name,
  LOWER(email) AS email,
  SUBSTR(mobile_number, LENGTH(mobile_number) - 9, 10) AS mobile_number,
  order_id,
  SUBSTR(order_id, 5, 4) AS order_year,
  order_date,
  delivery_date,
  DATEDIFF(delivery_date, order_date) AS delivery_days,
  ROUND(order_amount, 2) AS order_amount,
  UPPER(city) AS city,
  signup_date,
  DATEDIFF(NOW(), signup_date) AS customer_tenure_days,
  CASE
    WHEN order_amount >= 50000 THEN 'High Value'
    WHEN order_amount >= 20000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS order_category,
  ROUND(rating, 1) AS rating,
   CASE
    WHEN DATEDIFF(NOW(), signup_date) <= 30 THEN 'New'
    WHEN DATEDIFF(NOW(), signup_date) <= 180 THEN 'Regular'
    ELSE 'Loyal'
  END AS customer_type
FROM customer_orders;

select * from customer_orders_cleaned
limit 10;