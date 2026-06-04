USE inventory_order_management_db;

-- 1. Total inventory value
SELECT
    SUM(i.quantity * p.unit_price) AS total_inventory_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id;

-- 2. Monthly sales summary
SELECT *
FROM v_monthly_sales_summary;

-- 3. Supplier purchase summary
SELECT *
FROM v_supplier_purchase_summary;

-- 4. Best selling products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.subtotal) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('SHIPPED', 'DELIVERED')
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC;

-- 5. Low stock report
SELECT
    sku,
    product_name,
    warehouse_name,
    quantity,
    reorder_level,
    stock_status
FROM v_current_inventory
WHERE stock_status = 'LOW STOCK';

-- 6. Warehouse-wise inventory value
SELECT
    w.warehouse_name,
    SUM(i.quantity * p.unit_price) AS warehouse_inventory_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY warehouse_inventory_value DESC;

-- 7. Category-wise inventory value
SELECT
    p.category,
    SUM(i.quantity) AS total_quantity,
    SUM(i.quantity * p.unit_price) AS total_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY total_value DESC;

-- 8. Products never sold
SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 9. Customer-wise revenue
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('SHIPPED', 'DELIVERED')
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- 10. Stock movement summary
SELECT
    p.product_name,
    sm.movement_type,
    SUM(sm.quantity) AS total_quantity
FROM stock_movements sm
JOIN products p ON sm.product_id = p.product_id
GROUP BY p.product_id, p.product_name, sm.movement_type
ORDER BY p.product_name;
