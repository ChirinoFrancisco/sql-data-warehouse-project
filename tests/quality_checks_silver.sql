/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy,
  and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading the data into the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- =======================================
-- Checking Quality Issues - crm_cust_info
-- =======================================
/*
	Check for nulls or duplicates in PK
	Expectation: No Result
*/

-- Checking duplicated or null id's

SELECT 
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Checking unwanted Spaces
-- With that query we got a list of all names that contains spaces
-- Expectation: No Results

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Data Standarization & Consistency

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

-- Final Look
SELECT 
	* 
FROM silver.crm_cust_info;

-- ======================================
-- Checking Quality Issues - crm_prd_info
-- ======================================

-- Checking duplicated or null id's
SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Checking unwanted spaces
-- Expectation: No Result
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Checking for Nulls or Negative Numbers
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders
SELECT 
	*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Final Look
SELECT 
	*
FROM silver.crm_prd_info;

-- ===========================================
-- Checking Quality Issues - crm_sales_details
-- ===========================================

-- Checking integrity of the id's to later do the joins
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);
--WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)

-- Checking for invalid date orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Checking Business Rules (Data Consistency)
SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	  -- Looking for Nulls
	  OR sls_sales IS NULL
	  OR sls_quantity IS NULL
	  OR sls_price IS NULL
	  -- Looking for Zeros
	  OR sls_sales <= 0
	  OR sls_quantity <= 0
	  OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- Final Look
SELECT 
	*
FROM silver.crm_sales_details;

-- ===========================================
-- Checking Quality Issues - erp_cust_az12
-- ===========================================

-- Removing unnecessary characters from cid
SELECT
	CASE
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
	END cid,
	bdate,
	gen
FROM silver.erp_cust_az12
WHERE cid LIKE '%AW00011000%';

-- Indentifying Out-of-Range Dates
SELECT DISTINCT
	bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT
	gen,
	CASE
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'n/a'
	END AS gen
FROM silver.erp_cust_az12;

-- Final Look
SELECT
	*
FROM silver.erp_cust_az12;

-- ======================================
-- Checking Quality Issues - erp_loc_a101
-- ======================================

SELECT DISTINCT
	cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- Final Look
SELECT
	*
FROM silver.erp_loc_a101;

-- =========================================
-- Checking Quality Issues - erp_px_cat_g1v2
-- =========================================

-- Final Look
SELECT 
	* 
FROM silver.erp_px_cat_g1v2;
