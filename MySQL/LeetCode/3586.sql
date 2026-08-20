-- 3586. Find COVID Recovery Patients
WITH first_positive as (
    SELECT
        patient_id,
        MIN(test_date) as fp_date,
        result
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative_after_pos as(
    SELECT
        ct.patient_id,
        fp.fp_date,
        MIN(ct.test_date) as fn_date
    FROM covid_tests as ct
    JOIN first_positive as fp
    ON ct.patient_id = fp.patient_id
    WHERE ct.result = 'Negative' AND ct.test_date > fp.fp_date
    GROUP BY ct.patient_id, fp.fp_date
)
SELECT
    fn.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(fn_date, fp_date) as recovery_time
FROM first_negative_after_pos as fn
JOIN patients as p
ON fn.patient_id = p.patient_id
ORDER BY recovery_time, patient_name;