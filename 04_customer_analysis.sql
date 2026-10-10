
-- Customer analysis: orders, revenue, gross profit, and average order value
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT o.order_id) AS orders_count,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    SUM(oi.quantity * p.cost) AS cost_of_goods,
    SUM(oi.quantity * (oi.unit_price - p.cost)) AS gross_profit,
    ROUND(
        SUM(oi.quantity * oi.unit_price)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY revenue DESC;
