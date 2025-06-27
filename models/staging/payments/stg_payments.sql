{{
    config( 
        materialized= 'table',
        schema = 'staging_dev'
    )
}}

with stg_payments as
(
    select * from {{ source("source_dev", "payments") }}
)
select * from stg_payments
