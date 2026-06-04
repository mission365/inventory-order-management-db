USE inventory_order_management_db;

-- 1. Show current inventory
SELECT *
FROM v_current_inventory;

-- 2. Show only low stock products
SELECT *
FROM v_current_inventory
WHERE stock_status = 'LOW STOCK';

-- 3. Show out of stock products
SELECT *
FROM v_current_inventory
WHERE stock_status = 'OUT OF STOCK';

-- 4. Warehouse-wise inventory
SELECT
    w.warehouse_name,
    p.product_name,
    i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
ORDER BY w.warehouse_name, p.product_name;

-- 5. Total stock quantity by product
SELECT
    p.product_name,
    SUM(i.quantity) AS total_quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;

-- 6. Product movement history
SELECT
    sm.movement_id,
    p.product_name,
    w.warehouse_name,
    sm.movement_type,
    sm.quantity,
    sm.reference_type,
    sm.reference_id,
    sm.note,
    sm.movement_date
FROM stock_movements sm
JOIN products p ON sm.product_id = p.product_id
JOIN warehouses w ON sm.warehouse_id = w.warehouse_id
ORDER BY sm.movement_date DESC;

-- 7. Inventory value by product
SELECT
    p.product_name,
    SUM(i.quantity) AS total_quantity,
    p.unit_price,
    SUM(i.quantity * p.unit_price) AS inventory_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.unit_price
ORDER BY inventory_value DESC;

-- 8. Add stock after purchase received
START TRANSACTION;

UPDATE inventory
SET quantity = quantity + 10
WHERE product_id = 1 AND warehouse_id = 1;

INSERT INTO stock_movements
(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id, note)
VALUES
(1, 1, 'IN', 10, 'PURCHASE_ORDER', 1, 'Additional stock received');

COMMIT;

-- 9. Reduce stock after sales order
START TRANSACTION;

UPDATE inventory
SET quantity = quantity - 2
WHERE product_id = 2
AND warehouse_id = 1
AND quantity >= 2;

INSERT INTO stock_movements
(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id, note)
VALUES
(2, 1, 'OUT', 2, 'SALES_ORDER', 1, 'Stock reduced after sales');

COMMIT;

-- 10. Manual stock adjustment
START TRANSACTION;

UPDATE inventory
SET quantity = 50
WHERE product_id = 4 AND warehouse_id = 1;

INSERT INTO stock_movements
(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id, note)
VALUES
(4, 1, 'ADJUSTMENT', 50, 'MANUAL', NULL, 'Manual stock count adjustment');

COMMIT;
