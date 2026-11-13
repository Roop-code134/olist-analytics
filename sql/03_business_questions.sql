-- Q1: Monthly revenue and month-over-month growth
WITH order_rev AS (
  SELECT order_id, SUM(payment_value) AS revenue
  FROM order_payments GROUP BY order_id
),
monthly AS (
  SELECT DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
         SUM(r.revenue) AS revenue
  FROM orders o
  JOIN order_rev r ON o.order_id = r.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp <  '2018-09-01'
  GROUP BY 1
)
SELECT month, ROUND(revenue,0) AS revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
             / LAG(revenue) OVER (ORDER BY month), 1) AS mom_growth_pct
FROM monthly ORDER BY month;

-- Q2: Top 10 categories by revenue
SELECT COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
       COUNT(DISTINCT oi.order_id) AS orders,
       ROUND(SUM(oi.price),0) AS revenue,
       ROUND(SUM(oi.freight_value),0) AS freight,
       RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
LEFT JOIN category_translation t ON t.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;

-- Q3: Repeat vs one-time customers
WITH cust AS (
  SELECT c.customer_unique_id,
         COUNT(DISTINCT o.order_id) AS orders,
         SUM(oi.price) AS spend
  FROM customers c
  JOIN orders o ON o.customer_id = c.customer_id
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp <  '2018-09-01'
  GROUP BY 1
)
SELECT CASE WHEN orders = 1 THEN 'one-time' ELSE 'repeat' END AS customer_type,
       COUNT(*) AS customers,
       ROUND(SUM(spend),0) AS revenue,
       ROUND(100.0 * SUM(spend) / SUM(SUM(spend)) OVER (), 1) AS pct_of_revenue
FROM cust GROUP BY 1;

-- Q4: Cohort retention
WITH first_order AS (
  SELECT c.customer_unique_id,
         MIN(DATE_TRUNC('month', o.order_purchase_timestamp)) AS cohort_month
  FROM customers c JOIN orders o ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY 1
),
activity AS (
  SELECT DISTINCT c.customer_unique_id,
         DATE_TRUNC('month', o.order_purchase_timestamp) AS active_month
  FROM customers c JOIN orders o ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-01'
)
SELECT f.cohort_month,
       (EXTRACT(YEAR FROM AGE(a.active_month, f.cohort_month)) * 12
        + EXTRACT(MONTH FROM AGE(a.active_month, f.cohort_month)))::INT AS month_number,
       COUNT(DISTINCT a.customer_unique_id) AS customers
FROM first_order f
JOIN activity a USING (customer_unique_id)
WHERE f.cohort_month BETWEEN '2017-01-01' AND '2018-06-01'
GROUP BY 1, 2
ORDER BY 1, 2;

-- Q5: Customer lifetime value by state
WITH cust AS (
  SELECT c.customer_unique_id, MAX(c.customer_state) AS state, SUM(oi.price) AS ltv
  FROM customers c
  JOIN orders o ON o.customer_id = c.customer_id
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp <  '2018-09-01'
  GROUP BY 1
)
SELECT state, COUNT(*) AS customers,
       ROUND(AVG(ltv),2) AS avg_ltv,
       ROUND(SUM(ltv),0) AS total_revenue
FROM cust GROUP BY state ORDER BY total_revenue DESC;

-- Q6: Delivery performance vs review score
SELECT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'late' ELSE 'on time' END AS delivery,
       COUNT(*) AS orders,
       ROUND(AVG(r.review_score), 2) AS avg_review
FROM orders o
JOIN order_reviews r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY 1;

-- Q7: Lowest-rated sellers (min 30 orders)
SELECT oi.seller_id, s.seller_state,
       COUNT(DISTINCT oi.order_id) AS orders,
       ROUND(SUM(oi.price),0) AS revenue,
       ROUND(AVG(r.review_score),2) AS avg_review,
       ROUND(100.0 * AVG((o.order_delivered_customer_date > o.order_estimated_delivery_date)::INT),1) AS pct_late
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN sellers s ON s.seller_id = oi.seller_id
JOIN order_reviews r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY 1, 2
HAVING COUNT(DISTINCT oi.order_id) >= 30
ORDER BY avg_review ASC
LIMIT 20;

-- Q8: Payment methods
SELECT p.payment_type,
       COUNT(DISTINCT p.order_id) AS orders,
       ROUND(SUM(p.payment_value),0) AS total_value,
       ROUND(AVG(p.payment_installments),1) AS avg_installments
FROM order_payments p
JOIN orders o ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY 1
ORDER BY total_value DESC;