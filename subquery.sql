create database ors;
use ors;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'Amit','Delhi'),
(2,'Neha','Mumbai'),
(3,'Rahul','Bangalore'),
(4,'Pooja','Delhi');

INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Home');

INSERT INTO products VALUES
(1,'Laptop',1,60000),
(2,'Mobile',1,30000),
(3,'Headphones',1,2000),
(4,'T-Shirt',2,800),
(5,'Jeans',2,2000),
(6,'Mixer',3,4000);

INSERT INTO orders VALUES
(101,1,'2024-01-10'),
(102,2,'2024-01-12'),
(103,3,'2024-01-15'),
(104,1,'2024-01-20'),
(105,4,'2024-01-22');

INSERT INTO order_items VALUES
(1,101,1,1),
(2,101,3,2),
(3,102,2,1),
(4,102,4,3),
(5,103,5,2),
(6,104,1,1),
(7,104,6,1),
(8,105,3,4);

select * from customers;
select * from orders;

-- Q1. Find products that are priced higher than the average product price.
select 
product_name, 
round(price, 0) 
from products
where price > (select avg(price) from products);

-- Q2. Find customers who have placed at least one order.
select 
customer_name 
from customers
where customer_id in (select customer_id from orders); 

-- Q3. Find products that are the most expensive within their own category.
select c.category_name, p1.product_name, p1.category_id, p1.price
from products p1
join categories c on c.category_id = p1.category_id
where price = (select max(price) from products p2 where p1.category_id = p2.category_id);

-- Q4. Find customers who have ordered Electronics products.
select customer_name
from customers c 
where exists 
    (select customer_name 
     from orders o 
     join order_items oi on o.order_id = oi.order_id
     join products p on oi.product_id = p.product_id 
     where o.customer_id = c.customer_id and p.category_id = 1
     );
-- alternate
select customer_name
from customers c 
where exists 
    (select customer_name 
     from orders o 
     join order_items oi on o.order_id = oi.order_id
     join products p on oi.product_id = p.product_id 
     join categories ct on ct.category_id = p.category_id
     where o.customer_id = c.customer_id and ct.category_name = 'Electronics'
     );
     
-- Q5. Products cheaper than average price
select product_name from products
where price < (select avg(price) from products);

-- Q6. Customers from cities that have orders
select customer_name, city from customers c
where c.customer_id in (select customer_id from orders o
                      where c.customer_id = o.customer_id);


-- Q7. Cheapest product in each category
select c.category_name, p1.product_name 
from products p1
join categories c on p1.category_id = c.category_id
where p1.price = (select min(p2.price) from products p2 
                  where p1.category_id in (p2.category_id));

-- Q8. Customers who ordered Clothing
select distinct c.customer_name 
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
join categories ct on p.category_id = ct.category_id
where exists (select ct2.category_name from categories ct2 where ct2.category_name = 'Clothing')
