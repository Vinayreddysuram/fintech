{{ config(
    materialized = 'table',
    schema = 'staging_dev'
) }}

with source as (

    select * 
    from {{ source('source_dev', 'payments') }}

),

renamed as (

    select
        id as payment_id,
        customer_id,
        amount,
        status,
        payment_method,
        paid_at,

        paid_at::date as payment_date,
        date_trunc('month', paid_at) as payment_month,
        
        -- Flags for success/failure
        case when status = 'success' then 1 else 0 end as is_successful,
        case when status != 'success' then 1 else 0 end as is_failed

    from source

)

select * from renamed
