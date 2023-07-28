# dbt Bootcamp on Udemy
Objective: learn dbt by transforming airbnb data
</br>
We used publically accessible data about Berlin, Germany.
</br>
Snowflake was used as the data warehouse while dbt was the data transformation layer.

## End result
### Data model
Great quality raw data was read into the source files, adjusting the column names for consistency. The data was cleaned and parsed, then joined into new views/tables/ephemeral materializations.
</br>

![lineage graph](dbtbootcamp/assets/lineage_graph.png)
### Dashboard summary
Built using Preset.io
</br>

![dashboard summary](dbtbootcamp/assets/dashboard-dbt-airbnb-summary.png)
</br>
</br>

## Data that has undergone transformation:
### dim_listings_w_hosts
![dim_listings_w_hosts](dbtbootcamp/assets/dim_listings_w_hosts.png)
### mart_fullmoon_reviews
![mart_fullmoon_reviews](dbtbootcamp/assets/mart_fullmoon_reviews.png)

</br>

## Raw data preview
![input schema](dbtbootcamp/assets/input_schema.png)

</br>

## Functionality used
### Cleansing using SQL and Jinja
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
</br>

### Tests: custom, built-in, external packages

```sql
-- Custom made test, as a takehome assignment:
-- Checks that there is no review date that is submitted before its listing was created
-- Make sure that every review_date in fct_reviews is more recent than the associated created_at in dim_listings_cleansed

{% test consistent_review_created_at(model) %}

SELECT * FROM  {{ ref('dim_listings_cleansed') }} lc
INNER JOIN {{ ref('fct_reviews') }} f
USING (listing_id)
WHERE f.review_date < lc.created_at

{% endtest %}
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
</br>

### Example of Snapshots
```sql
-- A snapshot of the raw listings data, to monitor and keep track of all past versions

{% snapshot scd_raw_listings %}

{{
   config(
       target_schema='dev',
       unique_key='id',
       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}}
-- invalidate_hard_deletes - deletes are monitored too
-- strategy, updated_at - monitor by timestamp (by updated_at)


SELECT * FROM {{ source('airbnb', 'listings') }}

{% endsnapshot %}
```
### Snapshot @ change in minimum_nights:
![scd_raw_listings](dbtbootcamp/assets/snapshot-scd_raw_listings.png)

</br>

## How to: run it yourself
### Work in progress

## Actual documentation:
### Work in progress
