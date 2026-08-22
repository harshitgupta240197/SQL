-- 3580. Find Consistently Improving Employees
WITH ranked AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM performance_reviews
)
SELECT 
    r1.employee_id,
    e.name,
    r1.rating - r3.rating AS improvement_score
FROM ranked AS r1
JOIN ranked AS r2
ON r2.employee_id = r1.employee_id AND r2.rn = 2
JOIN ranked AS r3
ON r3.employee_id = r1.employee_id AND r3.rn = 3
JOIN employees AS e 
ON e.employee_id = r1.employee_id
WHERE 
    r1.rn = 1 AND
    r1.rating > r2.rating AND
    r2.rating > r3.rating
ORDER BY 
    improvement_score DESC,
    e.name ASC