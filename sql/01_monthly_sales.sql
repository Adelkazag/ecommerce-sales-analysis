SELECT
    DATE_TRUNC('month', o.order_date)::date AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_date)::date
ORDER BY month;
