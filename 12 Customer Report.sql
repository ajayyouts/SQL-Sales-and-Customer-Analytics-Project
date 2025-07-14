/* 

CUSTOMER REPORT

*/
CREATE VIEW gold.report_customers AS

-- Base Query: retrieve core columns from tables

WITH base_query as (
SELECT
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ', c.last_name) as customer_name,
DATEDIFF(year, c.birthdate, GETDATE()) as age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL)

-- Customer Aggregation
, customer_aggregation as (

SELECT
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) as total_orders,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_quantity,
COUNT(DISTINCT product_key) as total_products,
MAX(order_date) as last_order_date,
DATEDIFF (month, MIN(order_date), MAX(order_date)) as lifespan
FROM base_query
GROUP BY
customer_key,
customer_number,
customer_name,
age
)

SELECT
customer_key,
customer_number,
customer_name,
age,
CASE
WHEN age < 20 THEN 'Under 20'
WHEN age BETWEEN 20 AND 29 THEN '20-29'
WHEN age BETWEEN 30 and 39 THEN '30-39' 
WHEN age BETWEEN 40 and 49 THEN '40-40'
ELSE '50 and above'
END as age_group,
CASE
WHEN lifespan >= 12 and total_sales > 5000 THEN 'VIP'
WHEN lifespan >= 12 and total_sales <= 5000 THEN 'Regular'
ELSE 'New'
END AS customer_segment,
last_order_date,
DATEDIFF(month, last_order_date, GETDATE()) as recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
-- Compute average order value
CASE
WHEN total_orders = 0 THEN 0
ELSE total_sales / total_orders 
END AS avg_order_value,
-- Compute average monthly spend
CASE
WHEN lifespan = 0 THEN total_sales
ELSE total_sales / lifespan
END AS avg_monthly_spend
FROM customer_aggregation
