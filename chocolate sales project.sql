use chocolate_sales_db;
/*product table*/
  CREATE TABLE products (
  product_id VARCHAR(10),
    product_name VARCHAR(100),
    brand VARCHAR(50),
    category VARCHAR(50),
    cocoa_percent DECIMAL(5,2),
    weight_g INT
);
/*stores table*/
CREATE TABLE stores (
    store_id VARCHAR(10),
    store_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    store_type VARCHAR(50)
);
/*customer table*/
CREATE TABLE customers (
    customer_id VARCHAR(10),
    age INT,
    gender ENUM('Male', 'Female'),
    loyalty_member BOOLEAN,
    join_date DATE
);
/*date table*/
CREATE TABLE calendar (
    date DATE,
    year INT,
    month INT,
    day INT,
    week INT,
    day_of_week VARCHAR(10)
);
/*sales table*/
CREATE TABLE sales (
    order_id VARCHAR(20),
    order_date DATE,
    product_id VARCHAR(10),
    store_id VARCHAR(10),
    customer_id VARCHAR(10),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    revenue DECIMAL(12,2),
    cost DECIMAL(12,2),
    profit DECIMAL(12,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_date) REFERENCES calendar(date)

);
select *
from customers;
/* Total revenue*/
SELECT 
    ROUND(SUM(revenue), 2) AS total_revenue
FROM Sales;
/*Total profit*/
SELECT 
    ROUND(SUM(profit), 2) AS total_profit
FROM Sales;
/*Profit Margin*/
SELECT 
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS profit_margin
FROM Sales;

/*Revenue by Chocolate Category*/
SELECT 
    p.category,
    ROUND(SUM(s.revenue), 2) AS revenue
FROM sales s
JOIN product p
ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

/*Top 5 Best-Selling Products*/
SELECT 
    p.product_name,
    ROUND(SUM(s.revenue), 2) AS total_sales
FROM Sales_table s
JOIN Product_table p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 5;

/*Revenue and Profit by Country*/
SELECT 
    st.country,
    ROUND(SUM(s.revenue), 2) AS revenue,
    ROUND(SUM(s.profit), 2) AS profit
FROM Sales_table s
JOIN Stores_table st
ON s.store_id = st.store_id
GROUP BY st.country
ORDER BY revenue DESC;

/*Monthly Revenue Trend*/
SELECT 
    d.month_name,
    ROUND(SUM(s.revenue), 2) AS monthly_revenue
FROM Sales_table s
JOIN Date_table d
ON s.date_id = d.date_id
GROUP BY d.month_name
ORDER BY d.month_number;

/*Year-wise Revenue Comparison*/
SELECT 
    d.year,
    ROUND(SUM(s.revenue), 2) AS yearly_revenue
FROM Sales_table s
JOIN Date_table d
ON s.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;

/*Customer Distribution by Gender*/
SELECT 
    gender,
    COUNT(customer_id) AS total_customers
FROM Customer_table
GROUP BY gender;

/*Loyalty Members vs Non-Members*/
SELECT 
    loyalty_member,
    COUNT(customer_id) AS customer_count
FROM Customer_table
GROUP BY loyalty_member;