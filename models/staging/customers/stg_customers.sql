{{ 
    config(
        schema='staging_dev',
        materialized='table'
    ) 
}}

with stg_customers as (
    select * from {{ source("mysource", "customers") }}
)
select * from stg_customers