-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 08: Monthly Procurement Trend (ROLLUP)
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Monthly spend trend per supplier with automatic
--           subtotals and grand total using GROUP BY ROLLUP
-- Concepts: ROLLUP, NVL on rollup nulls, TO_CHAR date grouping,
--           NULLS LAST, multi-level aggregation
-- ============================================================

SELECT
    NVL(s.supplier_name, '>>> GRAND TOTAL')            AS supplier_name,
    NVL(TO_CHAR(po.po_date, 'MON-YYYY'), 'SUBTOTAL')   AS order_month,
    COUNT(po.po_id)                                     AS total_orders,
    SUM(po.total_amount)                                AS total_spend,
    ROUND(AVG(po.total_amount), 2)                      AS avg_order_value,
    MIN(po.total_amount)                                AS min_order,
    MAX(po.total_amount)                                AS max_order
FROM purchase_orders po
JOIN suppliers       s ON po.supplier_id = s.supplier_id
GROUP BY ROLLUP(
    s.supplier_name,
    TO_CHAR(po.po_date, 'MON-YYYY')
)
ORDER BY
    supplier_name NULLS LAST,
    order_month   NULLS LAST;
