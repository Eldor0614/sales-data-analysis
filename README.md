# Sales Data Analysis – SQL Business Intelligence Project

## Project Overview
This project implements a Business Intelligence (BI) solution using **SQL Server** for a retail bike sales company.
The goal is to transform raw transactional data into actionable business insights through
a structured data model, KPI-focused views, and reusable stored procedures.

The project simulates a real-world analytics workflow, starting from schema design and data ingestion
to performance reporting and decision support.

---

## Project Objectives
- Build a normalized relational database for retail sales data
- Load and transform CSV-based data using bulk insert techniques
- Design KPI-driven SQL views for reporting and analytics
- Implement stored procedures to support reusable and automated analysis
- Enable management-level insights for sales, inventory, staff, and regional performance

---

## Dataset
The dataset represents a bike retail chain and includes the following entities:
- Sales and Orders
- Order Items
- Customers
- Products
- Stores
- Inventory (Stocks)
- Staff
- Brands and Categories

**Note:**  
The dataset included in this repository is a **sample dataset** used to demonstrate the data model
and SQL logic. Full production data is excluded for confidentiality reasons.

---

## KPIs & Analytical Views

### Store Performance
- **vw_StoreSalesSummary**  
  Revenue, number of orders, and Average Order Value (AOV) per store

### Product Performance
- **vw_TopSellingProducts**  
  Products ranked by total sales revenue
- **vw_SalesByCategory**  
  Sales volume and margin by product category

### Inventory Monitoring
- **vw_InventoryStatus**  
  Identification of items running low on stock

### Staff Performance
- **vw_StaffPerformance**  
  Orders handled and revenue generated per staff member

### Regional Analysis
- **vw_RegionalTrends**  
  Revenue trends by city or region

---

## Stored Procedures

- **sp_CalculateStoreKPI**  
  Returns a complete KPI breakdown for a given store ID
- **sp_GenerateRestockList**  
  Generates a restocking list of low-stock items per store
- **sp_CompareSalesYearOverYear**  
  Compares sales performance between two selected years
- **sp_GetCustomerProfile**  
  Returns customer-level metrics including total spend, order count, and most purchased products

These procedures are designed to support dashboards, reporting tools, and automation workflows.

---

## Technical Highlights
- SQL Server–based implementation
- Normalized relational schema
- BULK INSERT for CSV data ingestion
- Extensive use of:
  - JOINs
  - CTEs
  - Window functions
  - Aggregations
- Business-oriented KPI design
- Reusable and parameterized stored procedures

---

## Repository Structure

