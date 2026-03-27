# Oracle SQL ERP Analytics — ShopNest Inc.

![Oracle SQL](https://img.shields.io/badge/Oracle-SQL-red)
![ERP](https://img.shields.io/badge/ERP-Analytics-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## Overview

This project contains 8 Oracle SQL analytics scripts built on a simulated ERP database for **ShopNest Inc.**, a fictional e-commerce company with $120M annual revenue and 3 warehouses across the US.

The scripts replicate real-world ERP reporting queries that procurement, inventory, and finance teams run daily inside Oracle Fusion Cloud SCM.


## Database Schema

6 core ERP tables modelled after Oracle Fusion SCM:

| Table | Description |
|-------|-------------|
| `suppliers` | Vendor master data |
| `items` | Product catalog with SKUs and reorder points |
| `warehouses` | 3 locations: New York, Chicago, Los Angeles |
| `inventory` | Stock levels per item per warehouse |
| `purchase_orders` | PO header with status and total amount |
| `po_lines` | PO line items with quantity and unit price |


## Scripts

| Script | File | Description | Key Concepts |
|--------|------|-------------|-------------|
| 01 | `ShopNest_Script01_Create_Tables.sql` | Create schema & load sample data | DDL, INSERT, COMMIT |
| 02 | `ShopNest_Script02_Inventory_Status.sql` | Real-time inventory status report | JOINs, CASE WHEN |
| 03 | `ShopNest_Script03_Low_Stock_Alert.sql` | Low stock alert with reorder suggestions | GREATEST(), NVL() |
| 04 | `ShopNest_Script04_Supplier_Spend.sql` | Supplier spend ranking and analysis | RANK(), SUM() OVER() |
| 05 | `ShopNest_Script05_PO_Aging_Report.sql` | PO aging with overdue flags | SYSDATE, date arithmetic |
| 06 | `ShopNest_Script06_Top_Items_Spend.sql` | Top items by spend + Pareto analysis | DENSE_RANK(), cumulative % |
| 07 | `ShopNest_Script07_Warehouse_Pivot.sql` | Side-by-side warehouse comparison | PIVOT, FOR ... IN() |
| 08 | `ShopNest_Script08_Procurement_Trend.sql` | Monthly spend trend with subtotals | GROUP BY ROLLUP |


## Oracle SQL Concepts Demonstrated

- `JOIN` — inner, left joins across multiple tables
- `CASE WHEN` — business logic for status flags and aging buckets
- `RANK()` and `DENSE_RANK()` — window functions for ranking
- `SUM() OVER()` — window aggregate for % of total calculations
- `GREATEST()` and `NVL()` — Oracle-specific functions
- `SYSDATE` and date arithmetic — days between dates
- `TO_CHAR(date, format)` — Oracle date formatting
- `PIVOT` — Oracle-specific row to column transformation
- `GROUP BY ROLLUP` — automatic subtotals and grand totals
- `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` — running totals


## How to Run

1. Create a free account at [livesql.oracle.com](https://livesql.oracle.com)
2. Open the SQL Worksheet
3. Run `Script 01` first to create and populate all tables
4. Run any of Scripts 02–08 in any order


## Business Context

These scripts mirror reports available natively in **Oracle Fusion Cloud SCM**:

| Script | Oracle Fusion Equivalent |
|--------|-------------------------|
| 02 — Inventory Status | Inventory Management Dashboard |
| 03 — Low Stock Alert | Automatic Purchase Requisition trigger |
| 04 — Supplier Spend | Supplier Spend Analysis in Oracle OAC |
| 05 — PO Aging | Payables Aging Report |
| 06 — Top Items | Procurement Pareto Analysis |
| 07 — Warehouse Pivot | Multi-Org Inventory Comparison |
| 08 — Monthly Trend | Procurement Spend Trend in Oracle OAC |


## Tools & Technologies

Oracle SQL · Oracle Live SQL · Oracle Fusion Cloud SCM · ERP Analytics · Procure-to-Pay


## Related Project

[Oracle Fusion SCM Implementation — ShopNest Inc.](../oracle-fusion-scm-shopnest)
Full ERP system design, gap analysis and implementation plan for the same fictional company.


*Built as a portfolio project to demonstrate Oracle SQL and ERP analytics skills.*
