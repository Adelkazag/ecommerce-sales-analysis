WITH monthly_sales AS (
 SELECT DATE_TRUNC('month', o.order_date)::date AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
 FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
 WHERE o.status = 'delivered' GROUP BY 1
), sales_dynamics AS (
 SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS previous_revenue
 FROM monthly_sales
)
SELECT month, revenue, previous_revenue,
       revenue - previous_revenue AS revenue_change,
       ROUND(100.0 * (revenue - previous_revenue)
         / NULLIF(previous_revenue, 0), 2) AS revenue_change_pct
FROM sales_dynamics ORDER BY month;
