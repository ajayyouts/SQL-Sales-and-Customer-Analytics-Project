-- Find the date of the first and last order
SELECT
MIN(order_date) as first_order_date,
MAX(order_date) as last_order_date,
DATEDIFF(year, min(order_date), max(order_date)) as order_range_years
FROM gold.fact_sales

-- Find the youngest and oldest customer
SELECT 
MIN(birthdate) as oldest_customer,
DATEDIFF(year, MIN(birthdate), GETDATE()) as oldest_age,
MAX(birthdate) as youngest_customer,
DATEDIFF(year, MAX(birthdate), GETDATE()) as youngest_age
From gold.dim_customers