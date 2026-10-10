SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(DISTINCT o.order_id) AS orders_count,
       SUM(oi.quantity * oi.unit_price) AS revenue,
       SUM(oi.quantity * (oi.unit_price - p.cost)) AS gross_profit
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY revenue DESC;
