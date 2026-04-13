# **Data Warehouse and Analytics Project**

Welcome to the **Data Warehouse and Analytics Project** repository!
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

---

## **Project Overview**

This project involves:

1. **Data Architecture:** Designing a Modern Data Warehouse using Medallion Architecture: **Bronze, Silver,** and **Gold** layers.
2. **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling:** Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting:** Creating SQL-based reports and dashboard for actionable insights.

---

## Project Requirements

**Building the Data Warehouse (Data Engineering)**

**Objective**

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

**Specifications**

- **Data Sources:** Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality:** Cleanse and resolve data quality issues prior to analysis.
- **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope:** Focus on the latest dataset only; historization of data is not required.
- **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

## **BI: Analytics & Reporting (Data Analytics)**

**Objective**

Develop SQL-based analytics to deliver detailed insights into:

- **Customer Behavior.**
- **Product Performance.**
- **Sales Trends.**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

For more details, refer to docs/requirements.md

---

## **Data Architecture**

The data architecture for this project follows the Medallion Architecture: **Bronze, Silver** and **Gold** layers.

![image.png](attachment:9bd0b471-1f5a-4747-b625-c8a66287f403:image.png)

1. **Bronze Layer:** Stores raw data as-is from the source systems. Data is ingested from CSV files into SQL Server Database.
2. **Silver Layer:** This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer:** Houses business-ready data modeled into a star schema required for reporting and analytics.

---

## **Repository Structure**

data-warehouse-project/
|
|— datasets/
|
|— docs/
|     |— etl.draw.io
|     |— data_architecture.drawio
|     |— data_catalog.md
|     |— data_flow.drawio
|     |— data_models.drawio
|     |— naming-conventions.md
|
|— scripts/
|     |— bronze/
|     |— silver/
|     |— gold/
|
|— tests/
|
|— README.md
|— LICENSE
|— .gitignore
|— requirements.txt

---

## **License**

This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.

---

## **About Me**

Hi! I’m **Francisco Chirino**, a software development student focused on backend development, with a strong interest in data engineering and analytics.
