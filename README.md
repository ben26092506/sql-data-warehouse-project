# Data Warehouse and Analytics Project

## Overview

This project demonstrates the design and implementation of a modern Data Warehouse using **SQL Server**.  
The goal is to consolidate sales-related data from multiple source systems, clean and transform the data, and provide a business-ready analytical data model for reporting and analysis.

The project follows a layered data architecture based on the **Medallion Architecture** with Bronze, Silver, and Gold layers. It covers the full data engineering workflow from raw data ingestion to analytical data modeling.

---

## Project Objectives

The main objective of this project is to build a SQL Server-based Data Warehouse that enables analytical reporting and supports data-driven decision-making.

The project focuses on:

- Consolidating data from CRM and ERP source systems
- Loading raw CSV data into SQL Server
- Cleaning and standardizing source data
- Integrating multiple data sources into a consistent data model
- Creating business-ready dimension and fact views
- Performing data quality checks across all layers
- Preparing the data model for reporting and analytics

---

## Data Architecture

The project follows the Medallion Architecture with three layers:

### Bronze Layer

The Bronze layer stores raw source data from the CRM and ERP systems.

Data is loaded from CSV files into SQL Server tables with minimal transformation.  
This layer keeps the source data close to its original structure and acts as the initial landing layer.

### Silver Layer

The Silver layer contains cleaned and standardized data.

In this layer, data quality issues are addressed, including:

- Removing unwanted spaces
- Standardizing categorical values
- Handling missing or invalid values
- Converting data types
- Cleaning date fields
- Resolving duplicate records
- Preparing data for analytical modeling

### Gold Layer

The Gold layer contains business-ready data models designed for reporting and analytics.

The data is modeled into a star schema with dimension and fact views, including:

- `gold.dim_customers`
- `gold.dim_products`
- `gold.fact_sales`

These views provide a structured analytical model for exploring customer behavior, product performance, and sales trends.

---

## Project Scope

This project focuses on the latest available dataset only.  
Historization of source data is not included.

The scope includes:

- Data ingestion from CSV files
- Data cleansing and standardization
- Data integration from ERP and CRM systems
- Star schema modeling
- SQL-based quality checks
- Documentation of naming conventions and data catalog

---

## Data Sources

The project uses CSV files from two source systems:

### CRM Source

CRM data includes customer, product, and sales-related information.

Example tables:

- `crm_cust_info`
- `crm_prd_info`
- `crm_sales_details`

### ERP Source

ERP data includes additional customer, location, and product category information.

Example tables:

- `erp_cust_az12`
- `erp_loc_a101`
- `erp_px_cat_g1v2`

---

## Technology Stack

This project was implemented with:

- **SQL Server**
- **SQL Server Management Studio**
- **T-SQL**
- **CSV files as source data**
- **Medallion Architecture**
- **Star Schema Data Modeling**

---

## Repository Structure

```text
.
├── datasets/                  # Source CSV files
├── docs/                      # Project documentation
│   ├── data_catalog.md
│   └── naming_conventions.md
├── scripts/                   # SQL scripts
│   ├── bronze/
│   ├── silver/
│   └── gold/
├── tests/                     # Data quality checks
└── README.md
```

---

## Data Engineering Workflow

### 1. Database Initialization

The project starts by creating the `DataWarehouse` database and the required schemas:

- `bronze`
- `silver`
- `gold`

### 2. Bronze Layer Creation

Bronze tables are created to store the raw source data from CSV files.

The tables are recreated during setup to ensure a clean development environment.

### 3. Bronze Layer Loading

Raw data is loaded into the Bronze tables using SQL Server `BULK INSERT`.

The loading process is handled by a stored procedure and includes progress messages and load duration tracking.

### 4. Silver Layer Creation

Silver tables are created with cleaned and more appropriate data types.

Additional technical metadata columns are included, such as:

- `dwh_create_date`

### 5. Silver Layer Loading

Data is transformed from Bronze to Silver using SQL logic.

Typical transformation steps include:

- Trimming text fields
- Standardizing values
- Handling nulls
- Cleaning dates
- Correcting inconsistent sales values
- Removing duplicates
- Deriving new fields

### 6. Gold Layer Modeling

The Gold layer is implemented as SQL views.

It provides a star schema model consisting of:

- Customer dimension
- Product dimension
- Sales fact view

This layer is designed for analytics and reporting.

### 7. Data Quality Checks

Data quality checks are included for both Silver and Gold layers.

The checks validate:

- Duplicate keys
- Null values
- Unwanted spaces
- Invalid dates
- Inconsistent categorical values
- Broken relationships between fact and dimension views

---

## Data Model

The Gold layer follows a star schema design.

### Dimension Views

`gold.dim_customers` contains customer master data enriched with demographic and geographic attributes.

`gold.dim_products` contains product information enriched with category and subcategory details.

### Fact View

`gold.fact_sales` contains sales transaction data and connects sales orders with customer and product dimensions.

---

## Analytics Use Cases

The final data model supports SQL-based analysis for:

- Customer behavior
- Product performance
- Sales trends
- Revenue analysis
- Order analysis
- Category and subcategory performance

Example business questions:

- Which products generate the highest revenue?
- Which customers contribute most to sales?
- How do sales develop over time?
- Which product categories perform best?
- Are there inconsistencies between sales amount, quantity, and price?

---

## Documentation

This repository includes documentation for:

- Naming conventions
- Data catalog
- Data quality checks
- Layered architecture
- Stored procedures
- Gold layer data model

The documentation is intended to make the project understandable for both technical and business users.

---

## Key Skills Demonstrated

This project demonstrates practical skills in:

- SQL development
- Data warehousing
- Data engineering
- ETL pipeline development
- Data cleansing
- Data quality validation
- Data modeling
- Star schema design
- Stored procedures
- SQL Server development
- Analytical data preparation

---

## How to Run the Project

1. Install SQL Server and SQL Server Management Studio.
2. Create the `DataWarehouse` database and schemas.
3. Create the Bronze tables.
4. Load the source CSV files into the Bronze layer.
5. Create the Silver tables.
6. Run the Silver layer loading procedure.
7. Create the Gold layer views.
8. Run the quality check scripts.
9. Use the Gold views for SQL-based analysis and reporting.

---

## Notes

This project is intended for learning and portfolio purposes.  
Some scripts reset or truncate tables before loading data to ensure reproducible results in a local development environment.

Do not run reset or truncate scripts in a production environment without proper review.

---

## Credits

The datasets used in this project are the publicly available datasets from Data With Baraa:

https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/datasets
