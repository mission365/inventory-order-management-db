USE inventory_order_management_db;

-- 1. Show all orders
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- 2. Show full order details
SELECT *
FROM v_order_details
ORDER BY order_id;

-- 3. Show pending orders
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'PENDING';

-- 4. Sales by product
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_sales_amount
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('SHIPPED', 'DELIVERED')
GROUP BY p.product_id, p.product_name
ORDER BY total_sales_amount DESC;

-- 5. Top customers by purchase amount
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('SHIPPED', 'DELIVERED')
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 6. Create a new sales order example
START TRANSACTION;

INSERT INTO orders
(customer_id, status, total_amount)
VALUES
(4, 'PENDING', 2550.00);

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, subtotal)
VALUES
(@new_order_id, 2, 3, 850.00, 2550.00);

UPDATE inventory
SET quantity = quantity - 3
WHERE product_id = 2
AND warehouse_id = 1
AND quantity >= 3;

INSERT INTO stock_movements
(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id, note)
VALUES
(2, 1, 'OUT', 3, 'SALES_ORDER', @new_order_id, 'Stock reduced for new sales order');

COMMIT;

-- 7. Update order status
UPDATE orders
SET status = 'SHIPPED'
WHERE order_id = 4;

-- 8. Cancel an order
UPDATE orders
SET status = 'CANCELLED'
WHERE order_id = 3;

-- 9. Daily sales report
SELECT
    DATE(order_date) AS sales_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM orders
WHERE status IN ('SHIPPED', 'DELIVERED')
GROUP BY DATE(order_date)
ORDER BY sales_date DESC;

-- 10. Customer order history
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.status,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = 1
ORDER BY o.order_date DESC;
