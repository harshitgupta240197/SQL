-- 3611. Find Overbooked Employees
WITH meeting_heavy AS(
    SELECT
        employee_id,
        YEARWEEK(meeting_date,3) AS wk
    FROM meetings
    GROUP BY employee_id, YEARWEEK(meeting_date,3)
    HAVING SUM(duration_hours) > 20
)
SELECT
    m.employee_id,
    e.employee_name,
    e.department,
    COUNT(*) AS meeting_heavy_weeks
FROM meeting_heavy AS m
JOIN employees AS e
ON m.employee_id = e.employee_id
GROUP BY m.employee_id
HAVING meeting_heavy_weeks >= 2
ORDER BY meeting_heavy_weeks DESC, e.employee_name ASC