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
-- invalidate_hard_deletes: with this argument, deletes are monitored too
-- monitor by timestamp, in particular by updated_at


SELECT * FROM {{ source('airbnb', 'listings') }}

{% endsnapshot %}