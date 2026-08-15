-- 3421. Find Students Who Improved
SELECT
    student_id,
    subject,
    MAX(CASE WHEN exam_date = min_date THEN score END) AS first_score,
    MAX(CASE WHEN exam_date = max_date THEN score END) AS latest_score
FROM (
    SELECT
        s.student_id,
        s.subject,
        s.score,
        s.exam_date,
        b.min_date,
        b.max_date
    FROM Scores s
    JOIN (
        SELECT
            student_id,
            subject,
            MIN(exam_date) AS min_date,
            MAX(exam_date) AS max_date,
            COUNT(*) AS exam_count
        FROM Scores
        GROUP BY student_id, subject
        HAVING COUNT(*) > 1
    ) b
      ON s.student_id = b.student_id
     AND s.subject = b.subject
) t
GROUP BY student_id, subject
HAVING latest_score > first_score
ORDER BY student_id, subject;