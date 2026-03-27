-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 07: Warehouse Stock Comparison (PIVOT)
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Side-by-side stock comparison across all 3
--           ShopNest warehouses using Oracle PIVOT
-- Concepts: PIVOT, FOR ... IN(), NVL(), subquery as source
-- ============================================================

SELECT
    item_name,
    category,
    NVL(new_york, 0)      AS new_york,
    NVL(chicago, 0)       AS chicago,
    NVL(los_angeles, 0)   AS los_angeles
FROM (
    SELECT
        i.item_name,
        i.category,
        w.warehouse_name,
        inv.quantity_on_hand
    FROM inventory  inv
    JOIN items      i ON inv.item_id      = i.item_id
    JOIN warehouses w ON inv.warehouse_id = w.warehouse_id
)
PIVOT (
    SUM(quantity_on_hand)
    FOR warehouse_name IN (
        'New York'       AS new_york,
        'Chicago'        AS chicago,
        'Los Angeles'    AS los_angeles
    )
)
ORDER BY category, item_name;
