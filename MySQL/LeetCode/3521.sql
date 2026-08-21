-- 3521. Find Product Recommendation Pairs
SELECT
    p1.product_id as product1_id,
    p2.product_id as product2_id,
    pt1.category as product1_category,
    pt2.category as product2_category,
    COUNT(p1.user_id) as customer_count
FROM ProductPurchases as p1
INNER JOIN ProductPurchases as p2
ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id
LEFT JOIN ProductInfo pt1 ON p1.product_id = pt1.product_id
LEFT JOIN ProductInfo pt2 ON p2.product_id = pt2.product_id
GROUP BY product1_id, product2_id
HAVING COUNT(p1.user_id) >= 3
ORDER BY customer_count DESC, product1_id, product2_id