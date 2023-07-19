{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}} --now that not recreated fully, if upstream has changed, this should fail

WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }}
)
SELECT * FROM src_reviews
WHERE review_text is not null
--only add if has content

{% if is_incremental() %}
  AND review_date > (select max(review_date) from {{ this }})
{% endif %} -- how to increment: based on review_date compare current to existing max.