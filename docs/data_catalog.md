# Data Catalog

## Overview

The Gold Layer represents the business-ready data model of the DataWarehouse.  
It contains cleaned, integrated, and analytics-friendly tables designed for reporting, dashboarding, and business analysis.

The Gold Layer is structured around dimension tables and fact tables. Dimension tables describe business entities such as customers and products, while fact tables store measurable business events such as sales transactions.

---

## 1. gold.dim_customers

### Purpose

The `gold.dim_customers` table contains customer master data enriched with demographic and geographic information. It is used to analyze customers by attributes such as name, country, marital status, gender, and birthdate.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| `customer_key` | INT | Surrogate key that uniquely identifies each customer record in the dimension table. |
| `customer_id` | INT | Numeric customer identifier from the source system. |
| `customer_number` | NVARCHAR(50) | Alphanumeric customer reference used for tracking and business identification. |
| `first_name` | NVARCHAR(50) | Customer's first name. |
| `last_name` | NVARCHAR(50) | Customer's last name or family name. |
| `country` | NVARCHAR(50) | Country associated with the customer. |
| `marital_status` | NVARCHAR(50) | Standardized marital status of the customer, for example `Married`, `Single`, or `n/a`. |
| `gender` | NVARCHAR(50) | Standardized gender value of the customer, for example `Male`, `Female`, or `n/a`. |
| `birthdate` | DATE | Customer's date of birth in date format. |
| `create_date` | DATE | Date when the customer record was originally created in the source system. |

---

## 2. gold.dim_products

### Purpose

The `gold.dim_products` table provides descriptive product information enriched with product category and subcategory details. It is used to analyze sales by product, category, product line, and other product attributes.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| `product_key` | INT | Surrogate key that uniquely identifies each product record in the product dimension table. |
| `product_id` | INT | Numeric product identifier from the source system. |
| `product_number` | NVARCHAR(50) | Alphanumeric product code used for product tracking, categorization, and referencing. |
| `product_name` | NVARCHAR(50) | Descriptive name of the product. |
| `category_id` | NVARCHAR(50) | Identifier of the product category used to link the product to its classification. |
| `category` | NVARCHAR(50) | High-level product category, such as bikes, components, clothing, or accessories. |
| `subcategory` | NVARCHAR(50) | More detailed product classification within the main category. |
| `maintenance_required` | NVARCHAR(50) | Indicates whether the product requires maintenance, for example `Yes` or `No`. |
| `cost` | INT | Product cost or base cost value. |
| `product_line` | NVARCHAR(50) | Product line or product series, such as Road, Mountain, Touring, or Other Sales. |
| `start_date` | DATE | Date from which the product record is valid or available. |

---

## 3. gold.fact_sales

### Purpose

The `gold.fact_sales` table contains transactional sales data prepared for analytical use cases. It connects sales orders with product and customer dimensions and provides key measures such as sales amount, quantity, and price.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| `order_number` | NVARCHAR(50) | Alphanumeric sales order identifier. |
| `product_key` | INT | Surrogate key referencing the related record in `gold.dim_products`. |
| `customer_key` | INT | Surrogate key referencing the related record in `gold.dim_customers`. |
| `order_date` | DATE | Date when the sales order was placed. |
| `shipping_date` | DATE | Date when the order was shipped. |
| `due_date` | DATE | Date when the order was due. |
| `sales_amount` | INT | Total sales value for the order line. |
| `quantity` | INT | Number of units sold for the order line. |
| `price` | INT | Unit price of the product for the order line. |
