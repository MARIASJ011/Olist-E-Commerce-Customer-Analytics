-- Export 1: rfm_segments.csv
SELECT * FROM rfm_segments;

-- Export 2: order_reviews_clean.csv
SELECT 
    r.review_id,
    r.order_id,
    r.review_score,
    r.review_comment_message,
    o.order_status,
    c.state
FROM order_reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE r.review_comment_message IS NOT NULL
AND r.review_comment_message != '';



-- Export 3: revenue_by_category.csv
SELECT 
    COALESCE(t.category_english, p.product_category_name) AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t ON p.product_category_name = t.category_portuguese
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name, t.category_english
ORDER BY total_revenue DESC;