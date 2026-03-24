/*
=======================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=======================================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
      - Truncates the bronze tables before loading data.
      - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or returns any values.

Usage Example:
    EXEC bronze.load_bronze;
=======================================================================================================
*/

-- Stored Procedure
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_bronze_time DATETIME, @end_bronze_time DATETIME;
	BEGIN TRY
		
		SET @start_bronze_time = GETDATE();
		PRINT 'Starting Bronze Load Procedure';
		
		PRINT '====================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================';

		PRINT '--------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		-- bronze.crm_cust_info
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
	
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, -- If the first row of the CSV file is the header with the column names do this
			FIELDTERMINATOR = ',', -- If the separator between values inside the CSV file is a , we put that, but each file can be different
			TABLOCK -- We lock the table during the insert of data.
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';
		-- Testing the quality of the insert

		-- First check if the data is in the correct column
		-- SELECT * FROM bronze.crm_cust_info

		-- Second, compare the amount of columns from the count with the amount inside the CSV file.
		-- If the csv has a header, we always are going to have 1 less row.
		-- SELECT COUNT(*) FROM bronze.crm_cust_info

		SET @start_time = GETDATE();
		-- bronze.crm_prd_info
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';

		-- SELECT * FROM bronze.crm_prd_info

		-- SELECT COUNT(*) FROM bronze.crm_prd_info

		SET @start_time = GETDATE();
		-- bronze.crm_sales_details
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';

		-- SELECT * FROM bronze.crm_sales_details

		-- SELECT COUNT(*) FROM bronze.crm_sales_details

		PRINT '--------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		-- bronze.erp_cust_az12
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';

		-- SELECT * FROM bronze.erp_cust_az12

		-- SELECT COUNT(*) FROM bronze.erp_cust_az12

		SET @start_time = GETDATE();
		-- bronze.erp_loc_a101
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
	
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';

		-- SELECT * FROM bronze.erp_loc_a101

		-- SELECT COUNT(*) FROM bronze.erp_loc_a101

		SET @start_time = GETDATE();
		-- bronze.erp_px_cat_g1v2
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
	
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------------------';

		-- SELECT * FROM bronze.erp_px_cat_g1v2

		-- SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
	
		SET @end_bronze_time = GETDATE();
		PRINT '====================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '		- Total Load Duration: ' + CAST(DATEDIFF(second, @start_bronze_time, @end_bronze_time) AS NVARCHAR) + ' seconds';
		PRINT '====================================';

	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END

-- TESTING

-- EXEC bronze.load_bronze
