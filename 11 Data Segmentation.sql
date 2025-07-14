-- Group the data based on a specific range
-- Helps understand the correlation between two measures
-- Measure by Measure

-- Segment products into cost ranges and count how many products fall into each segment.
WITH product_segments as (
SELECT
product_key,
product_name,
cost,
CASE
WHEN cost < 100 THEN 'Below 100'
WHEN cost BETWEEN 100 and 500 THEN '100-500'
WHEN cost BETWEEN 500 and 1000 THEN '500-1000'
ELSE 'Above 1000'
END cost_range
FROM gold.dim_products)

SELECT
cost_range,
COUNT(product_key) as total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC


-- Group customers into three segments based on their spending behavior
-- VIP: at least 12 months of history and spending more than $5000
-- Regular: at least 12 months of history but spending $5000 or less
-- New: lifespan less than 12 months
WITH customer_spending as (
SELECT
c.customer_key,
SUM(f.sales_amount) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
DATEDIFF (month, MIN(order_date), MAX(order_date)) as lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key)


SELECT
customer_segment,
COUNT(customer_key) as total_customers
FROM (
SELECT
customer_key,
CASE
WHEN lifespan >= 12 and total_spending > 5000 THEN 'VIP'
WHEN lifespan >= 12 and total_spending <= 5000 THEN 'Regular'
ELSE 'New'
END customer_segment
FROM customer_spending) t
GROUP BY customer_segment
ORDER BY total_customers DESC



