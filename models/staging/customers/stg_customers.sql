{{ 
    config(
        schema='staging_dev',
        materialized='table'
    ) 
}}

with stg_customers as (
    select * from {{ source("source_dev", "customers") }}
)

select * from stg_customers
