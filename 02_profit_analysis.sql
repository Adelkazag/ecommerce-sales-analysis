SELECT DATE_TRUNC('month', o.order_date)::date AS month,
       SUM(oi.quantity * oi.unit_price) AS revenue,
       SUM(oi.quantity * p.cost) AS cost_of_goods,
       SUM(oi.quantity * (oi.unit_price - p.cost)) AS gross_profit,
       ROUND(100.0 * SUM(oi.quantity * (oi.unit_price - p.cost))
         / NULLIF(SUM(oi.quantity * oi.unit_price), 0), 2) AS gross_margin_pct
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY 1 ORDER BY 1;
