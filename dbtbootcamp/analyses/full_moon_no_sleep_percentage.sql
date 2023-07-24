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
