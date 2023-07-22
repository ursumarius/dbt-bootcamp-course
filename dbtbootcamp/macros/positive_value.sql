{#
We are going to make this into a repeatable and custom generic test:

SELECT
	*
FROM
	{{ ref('dim_listings_cleansed')}}
WHERE minimum_nights < 1
LIMIT 10
#}


{% test positive_value(model, column_name) %}
	SELECT
		*
	FROM
		{{ model }}
	WHERE
		{{ column_name}} < 1
{% endtest %}
-- name of the test is what matters, not the file name