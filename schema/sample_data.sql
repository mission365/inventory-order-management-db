USE inventory_order_management_db;

INSERT INTO suppliers 
(supplier_name, contact_person, phone, email, address)
VALUES
('TechSource Ltd.', 'Rahim Uddin', '01711111111', 'techsource@example.com', 'Dhaka, Bangladesh'),
('OfficePro Supplies', 'Karim Ahmed', '01722222222', 'officepro@example.com', 'Chattogram, Bangladesh'),
('Global Traders', 'Nusrat Jahan', '01733333333', 'globaltraders@example.com', 'Sylhet, Bangladesh');

INSERT INTO warehouses
(warehouse_name, location, capacity)
VALUES
('Main Warehouse', 'Dhaka', 10000),
('Secondary Warehouse', 'Chattogram', 7000);

INSERT INTO products
(supplier_id, sku, product_name, category, unit_price, reorder_level)
VALUES
(1, 'SKU-001', 'Laptop Stand', 'Accessories', 1500.00, 10),
(1, 'SKU-002', 'Wireless Mouse', 'Accessories', 850.00, 15),
(2, 'SKU-003', 'Mechanical Keyboard', 'Accessories', 3500.00, 8),
(2, 'SKU-004', 'USB-C Cable', 'Cables', 450.00, 20),
(3, 'SKU-005', 'Office Chair', 'Furniture', 7500.00, 5),
(3, 'SKU-006', 'Desk Lamp', 'Furniture', 1200.00, 10),
(2, 'SKU-007', 'Notebook Pack', 'Stationery', 300.00, 25),
(3, 'SKU-008', 'Printer Paper', 'Stationery', 550.00, 30);

INSERT INTO inventory
(product_id, warehouse_id, quantity)
VALUES
(1, 1, 25),
(2, 1, 60),
(3, 1, 12),
(4, 1, 100),
(5, 2, 4),
(6, 2, 18),
(7, 2, 80),
(8, 2, 22);

INSERT INTO customers
(customer_name, phone, email, address)
VALUES
('Hasan Mahmud', '01811111111', 'hasan@example.com', 'Dhaka'),
('Sadia Islam', '01822222222', 'sadia@example.com', 'Chattogram'),
('Tanvir Ahmed', '01833333333', 'tanvir@example.com', 'Rajshahi'),
('Mim Akter', '01844444444', 'mim@example.com', 'Sylhet');

INSERT INTO orders
(customer_id, status, total_amount)
VALUES
(1, 'DELIVERED', 3050.00),
(2, 'SHIPPED', 5900.00),
(3, 'PENDING', 9700.00),
(1, 'PENDING', 3000.00);

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, subtotal)
VALUES
(1, 2, 2, 850.00, 1700.00),
(1, 4, 3, 450.00, 1350.00),
(2, 3, 1, 3500.00, 3500.00),
(2, 6, 2, 1200.00, 2400.00),
(3, 5, 1, 7500.00, 7500.00),
(3, 8, 4, 550.00, 2200.00),
(4, 1, 1, 1500.00, 1500.00),
(4, 7, 5, 300.00, 1500.00);

INSERT INTO purchase_orders
(supplier_id, warehouse_id, status, total_amount)
VALUES
(1, 1, 'RECEIVED', 50000.00),
(2, 1, 'RECEIVED', 55000.00),
(3, 2, 'PENDING', 63500.00);

INSERT INTO purchase_order_items
(purchase_order_id, product_id, quantity, unit_cost, subtotal)
VALUES
(1, 1, 20, 1000.00, 20000.00),
(1, 2, 50, 600.00, 30000.00),
(2, 3, 10, 2500.00, 25000.00),
(2, 4, 100, 300.00, 30000.00),
(3, 5, 5, 5500.00, 27500.00),
(3, 6, 20, 800.00, 16000.00),
(3, 8, 50, 400.00, 20000.00);

INSERT INTO stock_movements
(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id, note)
VALUES
(1, 1, 'IN', 20, 'PURCHASE_ORDER', 1, 'Stock received from supplier'),
(2, 1, 'IN', 50, 'PURCHASE_ORDER', 1, 'Stock received from supplier'),
(3, 1, 'IN', 10, 'PURCHASE_ORDER', 2, 'Stock received from supplier'),
(4, 1, 'IN', 100, 'PURCHASE_ORDER', 2, 'Stock received from supplier'),

(2, 1, 'OUT', 2, 'SALES_ORDER', 1, 'Product sold to customer'),
(4, 1, 'OUT', 3, 'SALES_ORDER', 1, 'Product sold to customer'),
(3, 1, 'OUT', 1, 'SALES_ORDER', 2, 'Product sold to customer'),
(6, 2, 'OUT', 2, 'SALES_ORDER', 2, 'Product sold to customer');
