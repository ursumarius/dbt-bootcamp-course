
WITH src_listings AS (
	SELECT * FROM {{ ref('src_listings')}}  -- stands for ref-erence the src_listings model
)

SELECT
  listing_id,
  listing_name,
  room_type,
  CASE -- the goal is to cleanse minimum_nights and ensure 0 nights is 1
    WHEN minimum_nights = 0 THEN 1
    ELSE minimum_nights
  END AS minimum_nights,
  host_id,
  REPLACE( -- we would also like to parse the string price into floats with 2 decimals
    price_str,
    '$'
  ) :: NUMBER(
    10,
    2
  ) AS price,
  created_at,
  updated_at
FROM
  src_listings