-- Find the Total Sales
SELECT SUM(sales_amount) as total_sales
FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) as total_quantity
FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) as avg_selling_price
FROM gold.fact_sales

-- Find the total number of orders
SELECT COUNT(DISTINCT(order_number)) as total_orders
FROM gold.fact_sales

-- Find the total number of products
SELECT COUNT(DISTINCT(product_key)) as total_products
FROM gold.dim_products

-- Find the total number of customers
SELECT COUNT(DISTINCT(customer_key)) as total_customers
FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT(customer_key)) as total_customers_orders
FROM gold.fact_sales

-- Report that shows all key metrics of the business

SELECT 'Total Sales' as measure_name, SUM(sales_amount) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' as measure_name, SUM(quantity) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT(order_number)) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products', COUNT(DISTINCT(product_key)) as measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(DISTINCT(customer_key)) as measure_value FROM gold.dim_customers