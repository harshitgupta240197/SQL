-- 184. Department Highest Salary
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee AS e
JOIN Department as d
ON e.departmentId = d.id
WHERE (e.departmentID, e.salary) IN (
    SELECT
        departmentId,
        MAX(salary)
    FROM Employee
    GROUP BY departmentId
)
