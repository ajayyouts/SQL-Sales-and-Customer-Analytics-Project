-- Which 5 products generate the highest revenue?
SELECT TOP 5
p.product_name,
sum(s.sales_amount) as total_revenue
FROM gold.dim_products p
JOIN gold.fact_sales s
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC


SELECT *
FROM(
SELECT
p.product_name,
sum(s.sales_amount) as total_revenue,
ROW_NUMBER() OVER (ORDER BY sum(s.sales_amount) DESC) as rank_products
FROM gold.dim_products p
LEFT JOIN gold.fact_sales s
ON p.product_key = s.product_key
GROUP BY p.product_name) t
WHERE rank_products <= 5

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
p.product_name,
sum(s.sales_amount) as total_revenue
FROM gold.dim_products p
JOIN gold.fact_sales s
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

--Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(s.sales_amount) as total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC

--The 3 customers with the fewest orders placed
SELECT 
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT s.order_number) as total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_orders 