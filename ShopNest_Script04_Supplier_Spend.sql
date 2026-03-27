-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 04: Supplier Spend Analysis
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Rank suppliers by total procurement spend,
--           calculate spend share and order statistics
-- Concepts: RANK(), SUM() OVER(), LEFT JOIN, GROUP BY,
--           NULLS LAST, window functions
-- ============================================================

SELECT
    s.supplier_name,
    s.country,
    s.payment_terms,
    s.status,
    COUNT(po.po_id)                                         AS total_orders,
    SUM(po.total_amount)                                    AS total_spend,
    ROUND(AVG(po.total_amount), 2)                          AS avg_order_value,
    MAX(po.total_amount)                                    AS largest_order,
    ROUND(
        SUM(po.total_amount) * 100.0 /
        SUM(SUM(po.total_amount)) OVER (), 2
    )                                                       AS spend_pct_of_total,
    RANK() OVER (ORDER BY SUM(po.total_amount) DESC)        AS spend_rank,
    NVL(TO_CHAR(MAX(po.po_date), 'DD-MON-YYYY'), 'None')   AS last_po_date
FROM suppliers        s
LEFT JOIN purchase_orders po ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_id,
    s.supplier_name,
    s.country,
    s.payment_terms,
    s.status
ORDER BY total_spend DESC NULLS LAST;
