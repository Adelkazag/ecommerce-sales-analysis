
WITH customer_orders AS (
    SELECT
        c.customer_id,
        COUNT(DISTINCT o.order_id) AS orders_count
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    WHERE o.status = 'delivered'
    GROUP BY c.customer_id
)
SELECT
    COUNT(*) AS customers_with_orders,
    COUNT(*) FILTER (
        WHERE orders_count > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE orders_count > 1
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_customer_pct
FROM customer_orders;
