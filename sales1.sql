create database sales;
use sales;

select * from sales;

alter table sales
rename column order_date to `order date`;

SELECT order_id, product, price, `order date`, city FROM sales LIMIT 10; -- limit is used to return the no. of rows given as argument

SELECT * FROM sales WHERE city = 'Tokyo';  -- used to return the values if the WHERE condition is true

SELECT order_id, product, price FROM sales -- it only selects 3 columns as given from sales table
ORDER BY price DESC -- sorting in descending order on the basis of price column
LIMIT 5; -- limit is used to return the no. of rows given as argument

SELECT order_id, product, price FROM sales -- it only selects 3 columns as given from sales table
ORDER BY price ASC -- sorting in ascending order on the basis of price column
LIMIT 5; -- limit is used to return the no. of rows given as argumentsales

select * from sales
where category = 'Electronics';

select distinct city from sales; -- distinct returns the unique values present in the column

select count(distinct product) as `unique products` from sales; -- COUNT counts the items and distinct seprates the unique values and AS create the column name


select order_id, product, `order date` from sales -- selecting 3 columns that we wanted in the result from sales table
where `order date` between '2025-09-01' and '2025-11-01' -- from order date column performing BETWEEN function used to define a range(start-end) but not ordered
order by `order date` asc; -- ORDER BY is used to present the data in the sorted way and ASC used for sorting in ascending order

select product, price, quantity, (price * quantity) as total from sales -- select 3 columns and creating extra column total which has agg value of price*quantity
order by total desc -- sorting the data in descending order on the basis of total
limit 5; -- returns only first five rows

select * from sales -- selects all the values from table sales
where city = 'osaka'; -- filtering table on the basis of city column

select distinct product from sales as `Unique Products`; -- only shows the list of products which are unique, DISTINCT returns number of unique values

select * from sales;

select order_id, product, price from sales -- selects 3 columns from sales tables
order by price desc -- sorting the data in descending order on the basis of price column
limit 3; -- returning only first 3 values

select * from sales
where `order date` between '2025-10-25' and '2025-11-06'
order by `order date`;

select product, category, quantity, city from sales 
where category = 'Stationery' and city = 'Tokyo' -- applying 2 conditions using AND
order by quantity desc -- sorting in descending order on the basis of quantity
limit 5; -- returns only first five rows

select product, sum(price*quantity) as revenue -- 
from sales
group by product
order by revenue desc
limit 1;


--


select product, price, quantity, sum(price*quantity) as revenue 
from sales 
group by product, price, quantity 
order by revenue desc 
limit 1;

SELECT product, SUM(price * quantity) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;
