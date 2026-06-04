# Database Normalization

## What is Normalization?

Normalization is the process of organizing database tables to reduce data duplication and improve data integrity.

This project follows normalization up to Third Normal Form, also known as 3NF.

## First Normal Form - 1NF

A table is in 1NF when:

- Each column contains atomic values.
- There are no repeating groups.
- Each row is unique.

### Example from This Project

The `orders` table does not store multiple products in one column.

Wrong design:

```txt
order_id | customer_name | products
1        | Hasan         | Mouse, Keyboard, Cable
