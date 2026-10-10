SELECT DATE_TRUNC('month', o.order_date)::date AS month,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY 1 ORDER BY 1;
