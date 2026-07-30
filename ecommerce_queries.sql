use ecommerce;
select count(*) from ecommerce_data;
-- basic select
select * from ecommerce_data limit 5;
-- selecting a specific column
select customer_id,product_name,category,unit_price from ecommerce_data  limit 10;
-- using where 
select * from ecommerce_data where country = 'India';
-- using order by to find the most expensive product 
select product_name,category,unit_price from ecommerce_data order by unit_price desc limit 10;
-- group by finding how many orders belong to each category
select category, count(*) as total_records from ecommerce_data group by category order by total_records desc;
-- using aggregate functions to find total quantity sold (sum)
select sum(quantity) as total_quantity_sold from ecommerce_data;
-- using aggregate functions to find average product price (avg)
select avg(unit_price) as average_price from ecommerce_data;
-- using aggregate functions to find total sales value by multiplying quantity*unit price
select sum(quantity*unit_price) as total_sales from ecommerce_data;
-- using aggregate functions to find average rating (avg)
select avg(rating) as average_rating from ecommerce_data;
-- GROUP BY + SUM
-- find sales by category
select category,sum(quantity*unit_price) as total_sales from ecommerce_data group by category order by total_sales desc;
-- INNER JOIN
-- creating new tables like customers products orders
create table customers as select distinct customer_id,first_name,last_name,gender,age_group,signup_date,country from ecommerce_data;
create table products as select distinct product_id,product_name,category,unit_price from ecommerce_data;
create table orders as select distinct order_id,customer_id,product_id,quantity,order_date,order_status,payment_method from ecommerce_data;
-- LEFT JOIN
SELECT c.customer_id,
       c.first_name,
       o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
-- RIGHT JOIN
SELECT c.customer_id,
       c.first_name,
       o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;
-- VIEW
CREATE VIEW category_sales AS
SELECT category,
       SUM(quantity * unit_price) AS total_sales,
       SUM(quantity) AS total_quantity
FROM ecommerce_data
GROUP BY category;
SELECT * FROM category_sales;
-- INDEX
CREATE INDEX idx_customer_id ON orders(customer_id);
-- QUERY OPTIMIZATION
SHOW TABLES;
CREATE TABLE products AS
SELECT DISTINCT
    product_id,
    product_name,
    category,
    unit_price
FROM ecommerce_data;
SHOW TABLES;
CREATE TABLE orders AS
SELECT DISTINCT
    order_id,
    customer_id,
    product_id,
    quantity,
    order_date,
    order_status,
    payment_method
FROM ecommerce_data;
SHOW TABLES;
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';
SHOW INDEX FROM orders;