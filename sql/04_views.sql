CREATE VIEW vw_orders_clean AS
SELECT o.order_id, c.customer_unique_id, c.customer_state, c.customer_city,
       o.order_purchase_timestamp, o.order_delivered_customer_date,
       o.order_estimated_delivery_date,
       (o.order_delivered_customer_date > o.order_estimated_delivery_date) AS is_late,
       pay.revenue, r.review_score
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN (SELECT order_id, SUM(payment_value) AS revenue
      FROM order_payments GROUP BY 1) pay ON pay.order_id = o.order_id
LEFT JOIN (SELECT order_id, AVG(review_score) AS review_score
           FROM order_reviews GROUP BY 1) r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01';