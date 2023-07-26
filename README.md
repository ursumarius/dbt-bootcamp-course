# dbt Bootcamp on Udemy
Objective: learn dbt by transforming airbnb data


## End result
### Data model
![lineage graph](dbtbootcamp/assets/lineage_graph.png)
### Dashboard summary
![dashboard summary](dbtbootcamp/assets/dashboard-dbt-airbnb-summary.png)
</br>
</br>

### End result preview
### dim_listings_w_hosts
![mart_fullmoon_reviews](dbtbootcamp/assets/mart_fullmoon_reviews.png)
### mart_fullmoon_reviews
![mart_fullmoon_reviews](dbtbootcamp/assets/mart_fullmoon_reviews.png)


## Raw data preview
![input schema](dbtbootcamp/assets/input_schema.png)
### Multiple tables
-- Explain a few fields which values could carry
</br>
-- Explain the need to cleanse some

## Functionality used
### Example cleansing SQL, mention other results
```sql
-- if the 'host_name' is missing, then use 'Anonymous'
  NVL(host_name, 'Anonymous') as host_name,
```
```sql
 -- cleanse 'minimum_nights' and ensure '0' nights is understood as '1'
  CASE
	WHEN minimum_nights = 0 THEN 1
    ELSE minimum_nights
  END AS minimum_nights,
```
```sql
 -- parse the string 'price' into a number w/ 2 decimals
  REPLACE(price_str,'$') :: NUMBER(10,2)
  AS price,
```
```sql
-- adding a new column that hashes 4 others using a jinja macro
{{dbt_utils.surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text'])}}
AS review_id

```
### Example of tests

```yaml
# custom made test
```

```yaml
# regular expression checking if source input string is formatted well
- dbt_expectations.expect_column_values_to_match_regex:
	regex: "^\\\\$[0-9][0-9\\\\.]+$"
```

```yaml
# outlier test,  whether 99% of the values fall in the chosen range
- dbt_expectations.expect_column_quantile_values_to_be_between:
	quantile: .99
	min_value: 50
	max_value: 500
```

## How to: run it yourself
### Work in progress