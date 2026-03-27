-- ============================================================
-- ShopNest Inc. | Oracle Fusion SCM Analytics
-- Script 01: Create & Populate ERP Tables
-- Author  : [Your Name]
-- Date    : March 2026
-- Purpose : Build core ERP schema for Inventory & Procurement
-- ============================================================

-- CREATE TABLES

CREATE TABLE suppliers (
    supplier_id    NUMBER PRIMARY KEY,
    supplier_name  VARCHAR2(100),
    country        VARCHAR2(50),
    payment_terms  VARCHAR2(20),
    status         VARCHAR2(20)
);

CREATE TABLE items (
    item_id        NUMBER PRIMARY KEY,
    sku            VARCHAR2(20),
    item_name      VARCHAR2(100),
    category       VARCHAR2(50),
    unit_price     NUMBER(10,2),
    reorder_point  NUMBER
);

CREATE TABLE warehouses (
    warehouse_id   NUMBER PRIMARY KEY,
    warehouse_name VARCHAR2(50),
    location       VARCHAR2(50)
);

CREATE TABLE inventory (
    inventory_id      NUMBER PRIMARY KEY,
    item_id           NUMBER REFERENCES items(item_id),
    warehouse_id      NUMBER REFERENCES warehouses(warehouse_id),
    quantity_on_hand  NUMBER,
    quantity_reserved NUMBER,
    last_updated      DATE
);

CREATE TABLE purchase_orders (
    po_id          NUMBER PRIMARY KEY,
    supplier_id    NUMBER REFERENCES suppliers(supplier_id),
    po_date        DATE,
    status         VARCHAR2(20),
    total_amount   NUMBER(12,2)
);

CREATE TABLE po_lines (
    line_id      NUMBER PRIMARY KEY,
    po_id        NUMBER REFERENCES purchase_orders(po_id),
    item_id      NUMBER REFERENCES items(item_id),
    quantity     NUMBER,
    unit_price   NUMBER(10,2)
);

-- INSERT SAMPLE DATA

-- Suppliers
INSERT INTO suppliers VALUES (1, 'TechSource Global',  'USA',    'NET30', 'Active');
INSERT INTO suppliers VALUES (2, 'ElectroHub Asia',    'China',  'NET45', 'Active');
INSERT INTO suppliers VALUES (3, 'PrimeGoods Ltd',     'India',  'NET30', 'Active');
INSERT INTO suppliers VALUES (4, 'FastParts Co',       'USA',    'NET15', 'Active');
INSERT INTO suppliers VALUES (5, 'GlobalSupply Inc',   'Germany','NET60', 'Inactive');

-- Items
INSERT INTO items VALUES (1, 'SKU-1001', 'Laptop 15"',         'Electronics',  850.00, 50);
INSERT INTO items VALUES (2, 'SKU-1002', 'Wireless Mouse',     'Accessories',   25.00, 200);
INSERT INTO items VALUES (3, 'SKU-1003', 'USB-C Hub',          'Accessories',   45.00, 150);
INSERT INTO items VALUES (4, 'SKU-1004', 'Monitor 27"',        'Electronics',  400.00, 30);
INSERT INTO items VALUES (5, 'SKU-1005', 'Mechanical Keyboard','Accessories',   95.00, 100);
INSERT INTO items VALUES (6, 'SKU-1006', 'Webcam HD',          'Electronics',   75.00, 80);
INSERT INTO items VALUES (7, 'SKU-1007', 'Office Chair',       'Furniture',    250.00, 20);
INSERT INTO items VALUES (8, 'SKU-1008', 'Standing Desk',      'Furniture',    550.00, 10);

-- Warehouses
INSERT INTO warehouses VALUES (1, 'New York',   'New York, NY');
INSERT INTO warehouses VALUES (2, 'Chicago',    'Chicago, IL');
INSERT INTO warehouses VALUES (3, 'Los Angeles','Los Angeles, CA');

-- Inventory
INSERT INTO inventory VALUES (1,  1, 1, 45,  5,  SYSDATE);
INSERT INTO inventory VALUES (2,  1, 2, 30,  2,  SYSDATE);
INSERT INTO inventory VALUES (3,  1, 3, 60,  0,  SYSDATE);
INSERT INTO inventory VALUES (4,  2, 1, 180, 20, SYSDATE);
INSERT INTO inventory VALUES (5,  2, 2, 90,  10, SYSDATE);
INSERT INTO inventory VALUES (6,  3, 1, 120, 15, SYSDATE);
INSERT INTO inventory VALUES (7,  3, 2, 40,  5,  SYSDATE);
INSERT INTO inventory VALUES (8,  4, 1, 22,  3,  SYSDATE);
INSERT INTO inventory VALUES (9,  4, 3, 18,  2,  SYSDATE);
INSERT INTO inventory VALUES (10, 5, 1, 85,  10, SYSDATE);
INSERT INTO inventory VALUES (11, 6, 2, 55,  5,  SYSDATE);
INSERT INTO inventory VALUES (12, 7, 3, 12,  2,  SYSDATE);
INSERT INTO inventory VALUES (13, 8, 3, 8,   1,  SYSDATE);

-- Purchase Orders
INSERT INTO purchase_orders VALUES (1001, 1, SYSDATE-30, 'Completed', 42500.00);
INSERT INTO purchase_orders VALUES (1002, 2, SYSDATE-20, 'Completed', 18750.00);
INSERT INTO purchase_orders VALUES (1003, 3, SYSDATE-10, 'Approved',  12300.00);
INSERT INTO purchase_orders VALUES (1004, 1, SYSDATE-5,  'Pending',    8500.00);
INSERT INTO purchase_orders VALUES (1005, 4, SYSDATE-2,  'Pending',    4750.00);
INSERT INTO purchase_orders VALUES (1006, 2, SYSDATE-45, 'Completed', 31200.00);
INSERT INTO purchase_orders VALUES (1007, 3, SYSDATE-15, 'Approved',   9800.00);
INSERT INTO purchase_orders VALUES (1008, 4, SYSDATE-60, 'Completed', 15600.00);

-- PO Lines
INSERT INTO po_lines VALUES (1,  1001, 1, 30,  850.00);
INSERT INTO po_lines VALUES (2,  1001, 4, 50,  400.00);
INSERT INTO po_lines VALUES (3,  1002, 2, 300,  25.00);
INSERT INTO po_lines VALUES (4,  1002, 3, 200,  45.00);
INSERT INTO po_lines VALUES (5,  1003, 5, 100,  95.00);
INSERT INTO po_lines VALUES (6,  1003, 6, 60,   75.00);
INSERT INTO po_lines VALUES (7,  1004, 1, 10,  850.00);
INSERT INTO po_lines VALUES (8,  1005, 7, 10,  250.00);
INSERT INTO po_lines VALUES (9,  1006, 4, 40,  400.00);
INSERT INTO po_lines VALUES (10, 1007, 8, 10,  550.00);
INSERT INTO po_lines VALUES (11, 1008, 2, 400,  25.00);
INSERT INTO po_lines VALUES (12, 1008, 3, 200,  45.00);

COMMIT;

-- VERIFY ROW COUNTS
SELECT 'suppliers'       AS table_name, COUNT(*) AS row_count FROM suppliers        UNION ALL
SELECT 'items'           AS table_name, COUNT(*) AS row_count FROM items             UNION ALL
SELECT 'warehouses'      AS table_name, COUNT(*) AS row_count FROM warehouses        UNION ALL
SELECT 'inventory'       AS table_name, COUNT(*) AS row_count FROM inventory         UNION ALL
SELECT 'purchase_orders' AS table_name, COUNT(*) AS row_count FROM purchase_orders   UNION ALL
SELECT 'po_lines'        AS table_name, COUNT(*) AS row_count FROM po_lines;
