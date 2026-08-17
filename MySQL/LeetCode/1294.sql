-- 1204. Last Person to Fit in the Bus
SELECT
    person_name
FROM
    (SELECT
        turn,
        person_id,
        person_name,
        SUM(weight) OVER(ORDER BY turn) AS i
    FROM Queue) AS sub_query
WHERE i <= 1000
ORDER BY i DESC
LIMIT 1;

