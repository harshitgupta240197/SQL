-- 180. Consecutive Numbers
SELECT
    DISTINCT a.num as ConsecutiveNums
FROM Logs as a
JOIN Logs as b
ON a.id = b.id + 1
JOIN Logs as c
ON a.id = c.id + 2
WHERE 
    a.num = b.num AND
    b.num = c.num