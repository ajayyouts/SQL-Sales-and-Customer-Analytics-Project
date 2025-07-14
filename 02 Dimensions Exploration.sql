-- Explore all countries customers come from
SELECT DISTINCT(country)
FROM gold.dim_customers

-- Explore all categories "The Major Divisions"
SELECT DISTINCT(category), subcategory
FROM gold.dim_products