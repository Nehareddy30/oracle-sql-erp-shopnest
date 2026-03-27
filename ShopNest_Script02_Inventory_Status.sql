-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 02: Inventory Status Report
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Real-time inventory status across all warehouses
--           with stock level flags and inventory valuation
-- Concepts: JOINs, CASE WHEN, calculated fields, ORDER BY CASE
-- ============================================================

SELECT
    w.warehouse_name                                    AS warehouse,
    i.sku,
    i.item_name,
    i.category,
    inv.quantity_on_hand,
    inv.quantity_reserved,
    (inv.quantity_on_hand - inv.quantity_reserved)      AS available_stock,
    i.reorder_point,
    CASE
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) <= 0
            THEN 'OUT OF STOCK'
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) < i.reorder_point
            THEN 'BELOW REORDER POINT'
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) < i.reorder_point * 1.2
            THEN 'LOW STOCK'
        ELSE 'OK'
    END                                                 AS stock_status,
    ROUND(inv.quantity_on_hand * i.unit_price, 2)       AS inventory_value
FROM inventory   inv
JOIN items       i ON inv.item_id      = i.item_id
JOIN warehouses  w ON inv.warehouse_id = w.warehouse_id
ORDER BY
    CASE
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) <= 0              THEN 1
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) < i.reorder_point THEN 2
        WHEN (inv.quantity_on_hand - inv.quantity_reserved) < i.reorder_point * 1.2 THEN 3
        ELSE 4
    END,
    w.warehouse_name,
    i.item_name;
