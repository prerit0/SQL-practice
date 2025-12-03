CREATE DATABASE zepto;
USE zepto;

DESC zepto_sales;

RENAME TABLE sales TO zepto;
DESC zepto;

SELECT * 
FROM zepto
LIMIT 5;

-- Q1: Show the first 8 rows with order_id, order_date, customer_id, product_name, total_amount 
SELECT order_id, order_date, customer_id, product_name, total_amount 
FROM zepto
ORDER BY order_date, order_id
LIMIT 8;

-- Q2: Show 15 delivered orders.
SELECT order_id, product_name, order_date, order_status, total_amount 
FROM zepto
WHERE LOWER(order_status) = 'delivered'
ORDER BY order_date DESC
LIMIT 15;

-- Q3: Delivered orders from Bengaluru with total_amount > 500
SELECT order_id, order_date,city,  total_amount 
FROM zepto
WHERE LOWER(order_status) = 'delivered' 
	  AND LOWER(city) = 'bengaluru' 
      AND total_amount > 500
ORDER BY total_amount DESC;

-- out of curiousity 
SELECT city, category, COUNT(*) AS count 
FROM zepto
WHERE city = 'jodhpur'
GROUP BY city, category;

-- Q4: Orders with total_amount between 300 and 700 (inclusive)
SELECT order_id, product_name,order_date, total_amount 
FROM zepto
WHERE total_amount 
      BETWEEN 300 AND 700
ORDER BY total_amount DESC;

SELECT * 
FROM zepto
LIMIT 1;

-- Q5: Orders placed between 2025-01-01 and 2025-03-31
SELECT order_id, order_date,total_amount, order_status 
FROM zepto
WHERE order_date 
	  BETWEEN '2025-01-01' AND '2025-03-31'
ORDER BY order_date
LIMIT 10;

-- Q6: Orders paid with UPI or Card.
SELECT order_id, total_amount, payment_method 
FROM zepto
WHERE LOWER(payment_method) IN ('upi','card')
ORDER BY total_amount DESC;
-- Q6 alternate
SELECT order_id, total_amount, payment_method 
FROM zepto
WHERE LOWER(payment_method) = 'upi' OR LOWER(payment_method) = 'card'
ORDER BY total_amount DESC;

-- Q7: Orders not from Delhi, Mumbai, or Bengaluru.
SELECT order_id,total_amount, city 
FROM zepto
WHERE city NOT IN ('delhi', 'mumbai', 'bengaluru')
ORDER BY total_amount DESC
LIMIT 10;

-- Q8: List distinct payment_method values.
SELECT DISTINCT payment_method 
FROM zepto;

-- Q9: Distinct (city, payment_method) pairs (exclude NULL city)
SELECT DISTINCT city, payment_method 
FROM zepto
WHERE city IS NOT NULL
ORDER BY city, payment_method;

SELECT * FROM zepto
LIMIT 1;

-- Q10: Find products with Rice in the name.
SELECT order_id, product_name, category 
FROM zepto
WHERE product_name LIKE '%Rice%';

-- Q11: Products that start with Frozen.
SELECT DISTINCT product_name 
FROM zepto
WHERE product_name LIKE 'Frozen%';

-- Q12: How many rows have missing city?
SELECT COUNT(city) 
FROM zepto
WHERE city IS NULL;

-- out of curiousity
SELECT DISTINCT payment_method, COUNT(order_status) AS c 
FROM zepto
GROUP BY payment_method;

-- Q13: Show rows where coupon_code is present but rating is missing (useful for “promo feedback” example).
seleCT ORDer_id, toTal_amount, coUpon_code, raTing 
from ZEPto
wherE COUpon_code is nOT NULl AND RATing is nULl;

-- Q14: Show order_id, price, quantity, and compute gross_amount = price * quantity with alias.
seleCT ORDer_id, prIce, quAntity, (pRiCe*quaNtity) as gROss_amount 
from ZEPto;

-- Q15: Show orders where gross (price*quantity) > 1000, order by gross descending.
seleCT ORDer_id,proDuct_id,proDuct_name, (pRiCe*quaNtity) as gROss_amount 
from ZEPto
grouP BY oRDer_id,proDuct_id,proDuct_name, grOss_amount
haviNG GROss_amount > 1000
ORDeR BY gROss_amount desc;
-- Q15 alternate
seleCT ORDer_id,proDuct_id,proDuct_name, (pRiCe*quaNtity) as gROss_amount 
from ZEPto
wherE (PRiCe*quaNtity) > 1000
ORDeR BY gROss_amount desc;

-- Q16: Top 10 orders by total_amount.
seleCT ORDer_id, toTal_amount 
from ZEPto
ordeR BY tOTal_amount desc
LIMiT 10;

-- Q17: Show rows 21-30 by order_date (oldest first).
SELECT ORDer_id, orDer_date, prOduct_name, toTal_amount 
FROM ZEPto
ORDER BY oRDer_date ASC
LIMIT 10 OFFSET 20;

-- Q18:  Dairy or Bakery products with names containing Butter or Bread.
seleCT ORDer_id, caTegory, prOduct_name 
from ZEPto
wherE CATegory in ('DaIry','BaKery') anD (PRoDuct_name like 'BUtter%' or pROduct_name like 'BRead%');

-- Q19: Delivered Express orders paid by Wallet with total_amount > 500.
seleCT ORDer_id, orDer_status, deLivery_type, paYment_method, toTal_amount 
from ZEPto
wherE ORDer_status = 'Delivered' 
      and DELivery_type = 'Express' 
      and PAYment_method = 'Wallet' 
      and TOTal_amount >500;
      
-- Q20: For Dairy category delivered between 2025-06-01 and 2025-08-31, paid by Card or UPI, show order_id, order_date, product_name, quantity, total_amount ordered by date.
 select order_id, order_date, product_name, quantity, total_amount
 from zepto
 where category = 'Dairy'
       and order_status = 'Delivered'
       and order_date between '2025-06-01' and '2025-08-31'
       and payment_method in ('Card','UPI')
 order by order_date desc;
 
seleCT CITy, suM(TOTAl_amount) as rEVenue 
from ZEPto
grouP BY cITy
haviNG REVenue > 50000;

SeleCT * FrOm ZEPto
limiT 1;

-- products sold more than 100 times
seleCT PROduct_id,ordEr_status, coUnT(QUANtity) as c 
from ZEPto 
grouP BY pROduct_id, orDer_status
haviNG C > 100 AND ORDer_status = 'DElivered';
-- alternate, this filters the delivered products before group by function in where funtion
seleCT PROduct_id, coUnT(QUANtity) as c 
from ZEPto  
wherE ORDer_status = 'DElivered'
grouP BY pROduct_id
haviNG C > 100;
