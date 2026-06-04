# Database Normalization

## Project Name

Inventory Order Management Database

## What is Normalization?

Normalization is the process of organizing data in a database to reduce data duplication, avoid data inconsistency, and improve data integrity.

In a poorly designed database, the same data may be repeated in many places. This can create problems when inserting, updating, or deleting records.

This project follows normalization up to **Third Normal Form**, also known as **3NF**.

---

## Why Normalization is Important

Normalization helps to:

- Reduce duplicate data
- Improve data accuracy
- Avoid update anomalies
- Avoid insert anomalies
- Avoid delete anomalies
- Make the database easier to maintain
- Create clean relationships between tables
- Improve long-term scalability

---

## Unnormalized Data Example

Before normalization, order data could be stored like this:

```txt
order_id | customer_name | customer_phone | product_names              | quantities
1        | Hasan Mahmud  | 01811111111    | Mouse, Cable               | 2, 3
2        | Sadia Islam   | 01822222222    | Keyboard, Desk Lamp        | 1, 2
```

This design is bad because:

- Multiple products are stored in one column.
- Multiple quantities are stored in one column.
- Customer information is repeated.
- Product information is not properly separated.
- Searching, updating, and reporting become difficult.

So, we divide the data into separate related tables.

---

# First Normal Form - 1NF

## Definition

A table is in **First Normal Form** when:

- Each column contains atomic values.
- There are no repeating groups.
- Each row is unique.
- Each table has a primary key.

Atomic value means one column should contain only one value.

---

## 1NF Problem Example

Wrong design:

```txt
order_id | customer_name | products
1        | Hasan Mahmud  | Mouse, Keyboard, Cable
```

Here, the `products` column contains multiple values. This violates 1NF.

---

## 1NF Solution

Correct design:

```txt
orders
order_id | customer_id | order_date
1        | 1           | 2026-06-04

order_items
order_item_id | order_id | product_id | quantity
1             | 1        | 2          | 2
2             | 1        | 4          | 3
```

Now every column contains a single value.

---

## 1NF Applied in This Project

This project follows 1NF because:

- Each table has a primary key.
- Each column stores only one value.
- Product list is not stored inside the `orders` table.
- Order products are stored separately in the `order_items` table.
- Purchase order products are stored separately in the `purchase_order_items` table.

Example:

```txt
orders
- order_id
- customer_id
- order_date
- status
- total_amount

order_items
- order_item_id
- order_id
- product_id
- quantity
- unit_price
- subtotal
```

---

# Second Normal Form - 2NF

## Definition

A table is in **Second Normal Form** when:

- It is already in 1NF.
- All non-key columns depend on the whole primary key.
- There is no partial dependency.

Partial dependency means a non-key column depends on only part of a composite key.

---

## 2NF Problem Example

Wrong design:

```txt
order_id | product_id | product_name | quantity | unit_price
1        | 2          | Mouse        | 2        | 850.00
1        | 4          | USB-C Cable  | 3        | 450.00
```

Here, `product_name` depends only on `product_id`, not on the whole order item record.

This creates duplication because the same product name may be repeated in many orders.

---

## 2NF Solution

Separate product data into a different table:

```txt
products
product_id | product_name | category     | unit_price
2          | Mouse        | Accessories  | 850.00
4          | USB-C Cable  | Cables       | 450.00

order_items
order_item_id | order_id | product_id | quantity | unit_price | subtotal
1             | 1        | 2          | 2        | 850.00     | 1700.00
2             | 1        | 4          | 3        | 450.00     | 1350.00
```

Now product information is stored only in the `products` table.

---

## 2NF Applied in This Project

This project follows 2NF because:

- Product details are stored in the `products` table.
- Customer details are stored in the `customers` table.
- Supplier details are stored in the `suppliers` table.
- Warehouse details are stored in the `warehouses` table.
- Order item details only store order-product relationship data.
- Purchase order item details only store purchase-product relationship data.

Example:

```txt
products
- product_id
- supplier_id
- sku
- product_name
- category
- unit_price
- reorder_level

order_items
- order_item_id
- order_id
- product_id
- quantity
- unit_price
- subtotal
```

The `order_items` table does not repeat product name, category, or supplier name.

---

# Third Normal Form - 3NF

## Definition

A table is in **Third Normal Form** when:

- It is already in 2NF.
- There is no transitive dependency.
- Non-key columns do not depend on other non-key columns.

Transitive dependency means one non-key column depends on another non-key column.

---

## 3NF Problem Example

Wrong design:

```txt
orders
order_id | customer_name | customer_phone | customer_address | order_date
1        | Hasan Mahmud  | 01811111111    | Dhaka            | 2026-06-04
```

Here, `customer_phone` and `customer_address` depend on `customer_name`, not directly on `order_id`.

This creates duplicate customer data if the same customer places multiple orders.

---

## 3NF Solution

Separate customer data into a different table:

```txt
customers
customer_id | customer_name | phone       | address
1           | Hasan Mahmud  | 01811111111 | Dhaka

orders
order_id | customer_id | order_date
1        | 1           | 2026-06-04
```

Now customer details are stored only once.

---

## 3NF Applied in This Project

This project follows 3NF because:

- Customer details are not stored in the `orders` table.
- Supplier details are not stored in the `products` table except `supplier_id`.
- Warehouse details are not stored in the `inventory` table except `warehouse_id`.
- Product details are not repeated in `order_items`.
- Product details are not repeated in `purchase_order_items`.
- Stock movement stores only references to product and warehouse.

Example:

```txt
customers
- customer_id
- customer_name
- phone
- email
- address

orders
- order_id
- customer_id
- order_date
- status
- total_amount
```

The `orders` table uses `customer_id` as a foreign key.

---

# Tables After Normalization

## 1. suppliers

The `suppliers` table stores supplier information.

```txt
supplier_id
supplier_name
contact_person
phone
email
address
created_at
```

### Purpose

This table removes supplier data duplication.

One supplier can supply many products.

---

## 2. products

The `products` table stores product information.

```txt
product_id
supplier_id
sku
product_name
category
unit_price
reorder_level
created_at
```

### Purpose

This table stores product details only once.

The `supplier_id` connects each product with a supplier.

---

## 3. warehouses

The `warehouses` table stores warehouse information.

```txt
warehouse_id
warehouse_name
location
capacity
created_at
```

### Purpose

This table stores warehouse details separately.

One warehouse can store many products.

---

## 4. inventory

The `inventory` table stores product stock quantity per warehouse.

```txt
inventory_id
product_id
warehouse_id
quantity
last_updated
```

### Purpose

This table solves the many-to-many relationship between products and warehouses.

One product can exist in many warehouses.

One warehouse can store many products.

---

## 5. customers

The `customers` table stores customer information.

```txt
customer_id
customer_name
phone
email
address
created_at
```

### Purpose

This table avoids repeating customer information in every order.

One customer can place many orders.

---

## 6. orders

The `orders` table stores sales order information.

```txt
order_id
customer_id
order_date
status
total_amount
```

### Purpose

This table stores main order information.

Customer details are connected using `customer_id`.

---

## 7. order_items

The `order_items` table stores products inside each sales order.

```txt
order_item_id
order_id
product_id
quantity
unit_price
subtotal
```

### Purpose

This table solves the many-to-many relationship between orders and products.

One order can have many products.

One product can appear in many orders.

---

## 8. purchase_orders

The `purchase_orders` table stores purchase order information.

```txt
purchase_order_id
supplier_id
warehouse_id
order_date
status
total_amount
```

### Purpose

This table stores purchase orders made to suppliers.

A purchase order is connected with a supplier and a warehouse.

---

## 9. purchase_order_items

The `purchase_order_items` table stores products inside each purchase order.

```txt
purchase_order_item_id
purchase_order_id
product_id
quantity
unit_cost
subtotal
```

### Purpose

This table solves the many-to-many relationship between purchase orders and products.

One purchase order can contain many products.

One product can appear in many purchase orders.

---

## 10. stock_movements

The `stock_movements` table stores inventory movement history.

```txt
movement_id
product_id
warehouse_id
movement_type
quantity
reference_type
reference_id
note
movement_date
```

### Purpose

This table tracks every stock change.

Stock movement can be:

- IN
- OUT
- ADJUSTMENT

This helps with inventory audit and reporting.

---

# Relationship Summary

```txt
suppliers 1 ---- many products

products 1 ---- many inventory
warehouses 1 ---- many inventory

customers 1 ---- many orders
orders 1 ---- many order_items
products 1 ---- many order_items

suppliers 1 ---- many purchase_orders
warehouses 1 ---- many purchase_orders

purchase_orders 1 ---- many purchase_order_items
products 1 ---- many purchase_order_items

products 1 ---- many stock_movements
warehouses 1 ---- many stock_movements
```

---

# Normalization Benefits in This Project

## 1. Reduced Data Duplication

Customer, supplier, product, and warehouse data are stored only once.

For example, customer phone and address are stored in the `customers` table, not repeatedly in the `orders` table.

---

## 2. Better Data Integrity

Foreign keys maintain valid relationships between tables.

Example:

```txt
orders.customer_id references customers.customer_id
```

This means an order must belong to a valid customer.

---

## 3. Easier Update

If a customer changes phone number, we update only one row in the `customers` table.

Without normalization, the same customer phone might need to be updated in many order records.

---

## 4. Easier Delete

If an order is deleted, customer information still remains safe in the `customers` table.

This avoids accidental loss of important customer data.

---

## 5. Easier Reporting

Reports can be generated using joins.

Example reports:

- Current inventory report
- Low stock report
- Monthly sales report
- Supplier purchase report
- Best selling products
- Warehouse-wise inventory value

---

# Anomalies Avoided

## Insert Anomaly

Without normalization, adding a new product might require order information.

In this project, products can be added independently in the `products` table.

---

## Update Anomaly

Without normalization, updating supplier information in multiple places may cause inconsistent data.

In this project, supplier data is stored only in the `suppliers` table.

---

## Delete Anomaly

Without normalization, deleting an order could also delete customer details.

In this project, deleting an order does not remove the customer record unless explicitly configured.

---

# Final Normalization Level

This database is designed up to **Third Normal Form - 3NF**.

The design separates data into meaningful tables, reduces duplication, and maintains relationships using primary keys and foreign keys.

---

# Conclusion

The Inventory Order Management Database follows proper normalization rules.

The database is clean, scalable, and suitable for managing inventory, suppliers, customers, sales orders, purchase orders, warehouses, and stock movement history.

This normalized design makes the database easier to maintain and better for generating business reports.
