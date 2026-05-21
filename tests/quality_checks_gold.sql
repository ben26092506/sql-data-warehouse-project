/*
===============================================================================
Gold Layer Quality Checks
===============================================================================
Script Purpose:
    This script validates the Gold Layer to ensure that the analytical data model
    is reliable, consistent, and ready for reporting.

    The checks focus on:
    - Verifying that surrogate keys in dimension views are unique.
    - Ensuring that fact records can be linked correctly to their related dimensions.
    - Detecting missing relationships between sales transactions, customers, and products.
    - Confirming that the Gold Layer supports accurate analytical and reporting use cases.

Usage Notes:
    - Run these checks after creating or refreshing the Gold Layer views.
    - Queries should ideally return no rows.
    - Any returned records indicate potential data model issues that should be reviewed
      and resolved in the Silver-to-Gold transformation logic.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check whether customer surrogate keys are unique
-- Expected Result: No rows
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================
-- Check whether product surrogate keys are unique
-- Expected Result: No rows
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check whether all fact records have matching customer and product dimension records
-- Expected Result: No rows
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;
