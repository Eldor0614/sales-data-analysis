# KPI & Business Metrics Documentation

## Overview
This document describes the key performance indicators (KPIs) implemented in this project.
All KPIs are designed to support data-driven decision-making for sales performance,
inventory management, and operational efficiency.

---

## Store-Level KPIs

### vw_StoreSalesSummary
**Purpose:**  
Provides a high-level sales overview per store.

**Metrics Included:**
- Total Revenue
- Number of Orders
- Average Order Value (AOV)

**Business Use Case:**  
Helps management compare store performance and identify high- and low-performing locations.

---

## Product & Inventory KPIs

### vw_TopSellingProducts
**Purpose:**  
Ranks products based on total sales revenue.

**Metrics Included:**
- Total Revenue per Product
- Sales Rank

**Business Use Case:**  
Supports product assortment decisions and promotional strategies.

---

### vw_InventoryStatus
**Purpose:**  
Identifies products with low stock levels.

**Metrics Included:**
- Current Stock Quantity
- Low-stock Indicator

**Business Use Case:**  
Prevents stock-outs and supports timely replenishment planning.

---

## Staff Performance KPIs

### vw_StaffPerformance
**Purpose:**  
Measures individual staff contribution to sales.

**Metrics Included:**
- Total Orders Handled
- Total Revenue Generated

**Business Use Case:**  
Used for performance evaluation, incentives, and staffing optimization.

---

## Regional & Category KPIs

### vw_RegionalTrends
**Purpose:**  
Analyzes revenue trends by city or region.

**Metrics Included:**
- Total Revenue by Region
- Order Volume

**Business Use Case:**  
Supports regional expansion and marketing strategy decisions.

---

### vw_SalesByCategory
**Purpose:**  
Evaluates sales performance by product category.

**Metrics Included:**
- Sales Volume
- Revenue
- Margin

**Business Use Case:**  
Helps identify high-margin categories and optimize pricing strategy.

---

## Stored Procedures

### sp_CalculateStoreKPI
**Description:**  
Returns a complete KPI breakdown for a given store ID.

**Use Case:**  
Used in dashboards or reporting tools for store-level performance analysis.

---

### sp_GenerateRestockList
**Description:**  
Generates a list of low-stock items per store.

**Use Case:**  
Supports inventory replenishment and supply chain planning.

---

### sp_CompareSalesYearOverYear
**Description:**  
Compares sales performance between two selected years.

**Use Case:**  
Used to analyze growth trends and seasonality.

---

### sp_GetCustomerProfile
**Description:**  
Returns customer-level metrics including total spend, order count,
and most frequently purchased products.

**Use Case:**  
Supports customer segmentation and loyalty analysis.

---

## How These KPIs Support Business Decisions
Together, these KPIs provide a comprehensive view of sales performance,
operational efficiency, and customer behavior, enabling management to make
informed strategic and tactical decisions.

