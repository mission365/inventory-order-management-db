# Requirements Document

## Project Name

Inventory Order Management Database

## Objective

The objective of this project is to design and implement a relational database system for managing company inventory, suppliers, customers, purchase orders, sales orders, warehouses, and stock movement history.

## Scope

This database system will support:

- Product management
- Supplier management
- Customer management
- Warehouse management
- Inventory tracking
- Sales order processing
- Purchase order processing
- Stock movement tracking
- Business reporting

## Functional Requirements

### 1. Supplier Management

The system should store supplier information such as:

- Supplier name
- Contact person
- Phone
- Email
- Address

One supplier can supply multiple products.

### 2. Product Management

The system should store product information such as:

- SKU
- Product name
- Category
- Unit price
- Reorder level
- Supplier

Each product belongs to one supplier.

### 3. Warehouse Management

The system should store warehouse information such as:

- Warehouse name
- Location
- Capacity

One warehouse can store many products.

### 4. Inventory Management

The system should track product quantity in each warehouse.

Inventory should include:

- Product
- Warehouse
- Quantity
- Last updated time

The same product can be stored in multiple warehouses.

### 5. Customer Management

The system should store customer information such as:

- Customer name
- Phone
- Email
- Address

One customer can place multiple orders.

### 6. Sales Order Management

The system should manage customer orders.

Each order should contain:

- Customer
- Order date
- Status
- Total amount

An order can contain multiple products.

### 7. Purchase Order Management

The system should manage purchases from suppliers.

Each purchase order should contain:

- Supplier
- Warehouse
- Order date
- Status
- Total amount

A purchase order can contain multiple products.

### 8. Stock Movement Tracking

The system should track all inventory changes.

Stock movement can be:

- IN
- OUT
- ADJUSTMENT

Stock movement helps audit inventory changes.

### 9. Reporting Requirements

The system should generate reports such as:

- Current inventory report
- Low stock report
- Inventory value report
- Monthly sales report
- Supplier purchase report
- Best selling product report
- Customer revenue report
- Warehouse-wise inventory value report

## Non-Functional Requirements

### Data Integrity

The system should use primary keys, foreign keys, and unique constraints to maintain correct data.

### Scalability

The database should support more products, customers, suppliers, warehouses, and orders in the future.

### Maintainability

The database should be normalized to reduce data duplication.

### Security

Sensitive business data should be protected by database user permissions in real production systems.

## Business Rules

- One supplier can have many products.
- One product can be stored in many warehouses.
- One warehouse can store many products.
- One customer can place many orders.
- One order can have many order items.
- One purchase order can have many purchase order items.
- Inventory quantity should decrease after sales.
- Inventory quantity should increase after purchase receiving.
- Products with quantity less than or equal to reorder level are considered low stock.
