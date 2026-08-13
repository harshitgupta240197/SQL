-- 1341. Movie Rating
(SELECT 
    u.name as results
FROM MovieRating AS m
JOIN Users as u
ON m.user_id = u.user_id
GROUP BY u.user_id
ORDER BY COUNT(m.rating) DESC, u.name ASC
LIMIT 1)

UNION ALL

(SELECT
    mo.title as results
FROM MovieRating as m
JOIN Movies as mo
ON m.movie_id = mo.movie_id
WHERE m.created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY mo.movie_id
ORDER BY AVG(m.rating) DESC, mo.title ASC
LIMIT 1)