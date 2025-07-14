-- Aggregate the data progressively over time.
-- Helps understand whether the business is growing or declining

-- Calculate the total sales per month, running total, and avg price
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) as running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) as moving_average_price
-- window function
FROM
(
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales,
AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t
