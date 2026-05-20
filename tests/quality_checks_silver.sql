/*
===============================================================================
Silver Layer Data Quality Checks
===============================================================================
Script Purpose:
    This script validates the quality, consistency, and standardization of data
    in the Silver layer of the DataWarehouse.

    The checks are designed to identify common data issues, including:
    - Missing or duplicate key values.
    - Unwanted leading or trailing spaces in text fields.
    - Inconsistent or non-standardized categorical values.
    - Invalid or unrealistic dates.
    - Incorrect date sequences.
    - Inconsistent relationships between sales, quantity, and price.

Usage Notes:
    - Run this script after loading or refreshing the Silver layer.
    - Queries returning no rows indicate that the corresponding check passed.
    - Any returned records should be reviewed and corrected in the transformation
      logic or source data where appropriate.
===============================================================================
*/

-- ====================================================================
-- Quality Checks for 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULL or duplicate customer IDs
-- Expected Result: No rows
SELECT 
    cst_id,
    COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for leading or trailing spaces in customer keys
-- Expected Result: No rows
SELECT 
    cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Check standardized customer marital status values
SELECT DISTINCT 
    cst_marital_status 
FROM silver.crm_cust_info;

-- ====================================================================
-- Quality Checks for 'silver.crm_prd_info'
-- ====================================================================
-- Check for NULL or duplicate product IDs
-- Expected Result: No rows
SELECT 
    prd_id,
    COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for leading or trailing spaces in product names
-- Expected Result: No rows
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for missing or negative product costs
-- Expected Result: No rows
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Check standardized product line values
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Check for invalid product date ranges
-- Expected Result: No rows
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ====================================================================
-- Quality Checks for 'silver.crm_sales_details'
-- ====================================================================
-- Check for invalid raw due date values before transformation
-- Expected Result: No invalid dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Check for invalid sales date sequences
-- Expected Result: No rows
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check consistency between sales amount, quantity, and price
-- Expected Result: No rows
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- Quality Checks for 'silver.erp_cust_az12'
-- ====================================================================
-- Check for unrealistic or future birthdates
-- Expected Result: Birthdates should be between 1924-01-01 and today
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Check standardized gender values
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;

-- ====================================================================
-- Quality Checks for 'silver.erp_loc_a101'
-- ====================================================================
-- Check standardized country values
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- Quality Checks for 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- Check for leading or trailing spaces in product category fields
-- Expected Result: No rows
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Check standardized maintenance values
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;
