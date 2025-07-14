-- Analyze how a measure evolves over time
-- Tracks trends and identify seasonality in your data

-- Total Sales, Customers, and Quantity Per Year
SELECT
YEAR(order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date is not null
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- Total Sales, Customers, and Quantity Per Month
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date is not null
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)