-- 550. Game Play Analysis IV
SELECT ROUND(
    COUNT(DISTINCT CASE 
        WHEN (player_id, event_date) IN (
            SELECT player_id, DATE_ADD(MIN(event_date), INTERVAL 1 DAY)
            FROM Activity
            GROUP BY player_id
        ) THEN player_id 
    END)
    / COUNT(DISTINCT player_id)
, 2) AS fraction
FROM Activity;