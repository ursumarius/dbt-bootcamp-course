WITH full_moon_review_sentiments AS (
    SELECT * FROM {{ ref('full_moon_no_sleep') }}
)
SELECT
    is_full_moon,
    review_sentiment,
    reviews
	REVIEWS * 100.0 / SUM(REVIEWS) OVER(PARTITION BY IS_FULL_MOON) AS PERCENTAGE_REVIEWS
FROM
    full_moon_review_sentiments



-- This is how to do it in one run, without an intermediary model:

-- SELECT department_name, AVG(salary) AS avg_salary
-- FROM (
--  SELECT e.employee_id, e.salary, d.department_name
--   FROM employees e
--   INNER JOIN departments d ON e.department_id = d.department_id
-- ) AS derived_table
-- GROUP BY department_name
-- HAVING COUNT(employee_id) >= 10;