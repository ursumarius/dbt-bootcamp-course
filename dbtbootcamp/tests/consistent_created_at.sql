
{% test consistent_review_created_at(model) %}

-- Lab: checks that there is no review date that is submitted before its listing was created:
-- Make sure that every review_date in fct_reviews is more recent than the associated created_at in dim_listings_cleansed

SELECT * FROM  {{ ref('dim_listings_cleansed') }} lc
INNER JOIN {{ ref('fct_reviews') }} f
USING (listing_id)
WHERE f.review_date < lc.created_at

{% endtest %}

