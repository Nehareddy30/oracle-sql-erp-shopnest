-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 06: Top Items by Procurement Value
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Rank items by total procurement spend, calculate
--           spend share and cumulative % (Pareto Analysis)
-- Concepts: RANK(), DENSE_RANK(), SUM() OVER(), cumulative
--           running total, ROWS BETWEEN window frame
-- ============================================================

SELECT
    i.sku,
    i.item_name,
    i.category,
    i.unit_price,
    SUM(pl.quantity)                                        AS total_qty_ordered,
    SUM(pl.quantity * pl.unit_price)                        AS total_spend,
    RANK() OVER (
        ORDER BY SUM(pl.quantity * pl.unit_price) DESC
    )                                                       AS spend_rank,
    DENSE_RANK() OVER (
        ORDER BY SUM(pl.quantity * pl.unit_price) DESC
    )                                                       AS dense_rank,
    ROUND(
        SUM(pl.quantity * pl.unit_price) * 100.0 /
        SUM(SUM(pl.quantity * pl.unit_price)) OVER (), 2
    )                                                       AS pct_of_total_spend,
    ROUND(
        SUM(SUM(pl.quantity * pl.unit_price)) OVER (
            ORDER BY SUM(pl.quantity * pl.unit_price) DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) * 100.0 /
        SUM(SUM(pl.quantity * pl.unit_price)) OVER (), 2
    )                                                       AS cumulative_pct
FROM po_lines   pl
JOIN items      i ON pl.item_id = i.item_id
GROUP BY
    i.item_id,
    i.sku,
    i.item_name,
    i.category,
    i.unit_price
ORDER BY spend_rank;
