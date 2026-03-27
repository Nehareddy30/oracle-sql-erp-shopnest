-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 03: Low Stock Alert Query
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Identify items below reorder point and calculate
--           suggested order quantity and estimated PO value
-- Concepts: GREATEST(), NVL(), TO_CHAR(), date formatting
-- ============================================================

SELECT
    i.sku,
    i.item_name,
    i.category,
    w.warehouse_name,
    inv.quantity_on_hand,
    inv.quantity_reserved,
    (inv.quantity_on_hand - inv.quantity_reserved)      AS available_stock,
    i.reorder_point,
    GREATEST(
        (i.reorder_point * 2) - inv.quantity_on_hand, 0
    )                                                   AS suggested_order_qty,
    ROUND(
        GREATEST((i.reorder_point * 2) - inv.quantity_on_hand, 0)
        * i.unit_price, 2
    )                                                   AS estimated_po_value,
    NVL(TO_CHAR(inv.last_updated, 'DD-MON-YYYY'), 'Never') AS last_updated
FROM inventory   inv
JOIN items       i ON inv.item_id      = i.item_id
JOIN warehouses  w ON inv.warehouse_id = w.warehouse_id
WHERE (inv.quantity_on_hand - inv.quantity_reserved) < i.reorder_point
ORDER BY estimated_po_value DESC;
