# dbt Bootcamp on Udemy
Objective: learn dbt by transforming airbnb data
</br>
We used publically accessible data about Berlin, Germany.
</br>
Snowflake was used as the data warehouse while dbt was the data transformation layer.

## End result
### Data model
Starting off with good quality raw data, which was read into the source files, adjusting the column names for consistency. The data was cleaned and parsed, then joined into tables with new columns.
</br>

![lineage graph](dbtbootcamp/assets/lineage_graph.png)
### Dashboard summary
Built using Preset.io
</br>

![dashboard summary](dbtbootcamp/assets/dashboard-dbt-airbnb-summary.png)
</br>
</br>

## Transformed tables:
### dim_listings_w_hosts
![mdim_listings_w_hosts](dbtbootcamp/assets/dim_listings_w_hosts.png)
### mart_fullmoon_reviews
![mart_fullmoon_reviews](dbtbootcamp/assets/mart_fullmoon_reviews.png)


## Raw data preview
![input schema](dbtbootcamp/assets/input_schema.png)

## Functionality used
### Examples of cleansing using SQL and Jinja
```sql
-- if the 'host_name' is missing, then use 'Anonymous'
  NVL(host_name, 'Anonymous')
  AS host_name,
```
```sql
 -- cleanse 'minimum_nights' and ensure '0' nights is understood as '1'
  CASE
	WHEN minimum_nights = 0 THEN 1
    ELSE minimum_nights
  END AS minimum_nights
```
```sql
 -- parse the string 'price' into a number w/ 2 decimals
  REPLACE(price_str,'$') :: NUMBER(10,2)
  AS price
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

## Actual documentation:
### Work in progress
