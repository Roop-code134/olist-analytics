-- 1. Order status distribution
SELECT order_status, COUNT(*) FROM orders GROUP BY 1 ORDER BY 2 DESC;

-- 2. Delivered orders missing a delivery date
SELECT COUNT(*) FROM orders
WHERE order_status = 'delivered' AND order_delivered_customer_date IS NULL;

-- 3. Products with no category
SELECT COUNT(*) FROM products WHERE product_category_name IS NULL;

-- 4. Date range of the data
SELECT MIN(order_purchase_timestamp), MAX(order_purchase_timestamp) FROM orders;

-- 5. Orders per month
SELECT DATE_TRUNC('month', order_purchase_timestamp) AS m, COUNT(*)
FROM orders GROUP BY 1 ORDER BY 1;