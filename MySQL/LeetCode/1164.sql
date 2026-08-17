-- 1164. Product Price at a Given Date
SELECT
    p.product_id,
    p.new_price as price
FROM Products p
JOIN (
    SELECT product_id, MAX(change_date) AS latest
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
) m
  ON p.product_id = m.product_id
 AND p.change_date = m.latest

UNION ALL

SELECT DISTINCT
    product_id,
    10 as price
FROM Products
WHERE 
    change_date > '2019-08-16' AND
    product_id NOT IN (
        SELECT
            product_id
        FROM Products
        WHERE change_date <= '2019-08-16'
    ) 
ORDER BY price DESC