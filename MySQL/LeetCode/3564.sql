-- 3564. Seasonal Sales Analysis
WITH
seasonal_sales AS (
    SELECT
        (CASE
            WHEN MONTHNAME(s.sale_date) IN ('December', 'January', 'February') THEN 'Winter'
            WHEN MONTHNAME(s.sale_date) IN ('March', 'April', 'May') THEN 'Spring'
            WHEN MONTHNAME(s.sale_date) IN ('June', 'July', 'August') THEN 'Summer'
            WHEN MONTHNAME(s.sale_date) IN ('September', 'October', 'November') THEN 'Fall' 
        END) AS season,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.price * s.quantity) AS total_revenue
    FROM sales as s
    JOIN products as p
    ON s.product_id = p.product_id
    GROUP BY season, p.category
),
ranked_categories AS (
    SELECT
        season, 
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS rnk
    FROM seasonal_sales
)
SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked_categories
WHERE rnk = 1
ORDER BY season