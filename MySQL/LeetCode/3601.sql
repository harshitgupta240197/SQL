-- 3601. Find Drivers with Improved Fuel Efficiency
WITH first_half AS (
    SELECT
        driver_id,
        AVG(distance_km / fuel_consumed) as first_half_avg
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 1 AND 6
    GROUP BY driver_id
), 
second_half AS (
    SELECT
        fh.driver_id,
        AVG(t.distance_km / t.fuel_consumed) as second_half_avg,
        fh.first_half_avg
    FROM trips as t
    JOIN first_half as fh
    ON t.driver_id = fh.driver_id
    WHERE MONTH(trip_date) BETWEEN 7 AND 12
    GROUP BY t.driver_id
)
SELECT
    sh.driver_id,
    d.driver_name,
    ROUND(first_half_avg,2) as first_half_avg,
    ROUND(second_half_avg,2) as second_half_avg,
    ROUND(second_half_avg - first_half_avg,2) as efficiency_improvement
FROM second_half as sh
JOIN drivers as d
ON sh.driver_id = d.driver_id
WHERE sh.second_half_avg > sh.first_half_avg
ORDER BY efficiency_improvement DESC, d.driver_name ASC
