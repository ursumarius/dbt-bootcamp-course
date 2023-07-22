{#
	no null check using jinja
#}

{% macro no_nulls_in_columns(model) %}
	SELECT * FROM {{ model }} WHERE
	{% for col in adapter.get_columns_in_relation(model) -%}
		{{ col.column }} IS NULL OR
	{% endfor %}
	FALSE
{% endmacro %}

-- - means that white space will be deleted.
-- OR FALSE for correct sql syntax
