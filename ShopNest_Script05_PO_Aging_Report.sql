-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 05: Purchase Order Aging Report
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Calculate PO age in days, bucket into aging
--           brackets and flag overdue orders for follow-up
-- Concepts: SYSDATE, TRUNC(), date arithmetic, CASE WHEN,
--           TO_CHAR() date formatting
-- ============================================================

SELECT
    po.po_id,
    s.supplier_name,
    s.payment_terms,
    TO_CHAR(po.po_date, 'DD-MON-YYYY')                     AS po_date,
    po.status,
    po.total_amount,
    TRUNC(SYSDATE - po.po_date)                             AS days_outstanding,
    CASE
        WHEN TRUNC(SYSDATE - po.po_date) <= 15  THEN '0-15 days'
        WHEN TRUNC(SYSDATE - po.po_date) <= 30  THEN '16-30 days'
        WHEN TRUNC(SYSDATE - po.po_date) <= 45  THEN '31-45 days'
        WHEN TRUNC(SYSDATE - po.po_date) <= 60  THEN '46-60 days'
        ELSE                                         'Over 60 days'
    END                                                     AS aging_bucket,
    CASE
        WHEN po.status IN ('Pending', 'Approved')
         AND TRUNC(SYSDATE - po.po_date) > 30
            THEN 'OVERDUE - Follow Up'
        WHEN po.status IN ('Pending', 'Approved')
         AND TRUNC(SYSDATE - po.po_date) > 15
            THEN 'REVIEW NEEDED'
        WHEN po.status = 'Completed'
            THEN 'Closed'
        ELSE 'On Track'
    END                                                     AS action_required
FROM purchase_orders po
JOIN suppliers       s ON po.supplier_id = s.supplier_id
ORDER BY days_outstanding DESC;
