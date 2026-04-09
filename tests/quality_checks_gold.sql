/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency,
    and accuracy of the Gold Layer, These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential inregrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purpose.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- =================================
-- CHECKING THE CUSTOMER's DIMENSION
-- =================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results

SELECT
	customer_key,
	COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ================================
-- CHECKING THE PRODUCT's DIMENSION
-- ================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results

SELECT
	product_key,
	COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ========================
-- CHECKING THE SALE's FACT
-- ========================
-- Check the data model connectivity between fact and dimension

SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;
