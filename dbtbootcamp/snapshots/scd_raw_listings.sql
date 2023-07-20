{% snapshot scd_raw_listings %}

{{
   config(
       target_schema='dev',
       unique_key='id',
       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}} -- invalidate_hard_deletes: this way, deletes are monitored too
--monitor by timestamp, in particular by updated_at


SELECT * FROM {{ source('airbnb', 'listings') }}

{% endsnapshot %}