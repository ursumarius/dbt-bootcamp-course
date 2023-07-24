WITH mart_fullmoon_reviews AS (
    SELECT * FROM {{ ref('mart_fullmoon_reviews') }}
)
SELECT
    is_full_moon,
    review_sentiment,
    COUNT(*) as reviews
FROM
    mart_fullmoon_reviews
GROUP BY
    is_full_moon,
    review_sentiment
ORDER BY
    is_full_moon,
    review_sentiment;

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

