{{ config(
    materialized = 'table',
    schema = 'marts_dev',
      transient= false
  
) }}

with customers as (

    select
        id as customer_id,
        name,
        email,
        created_at::date as signup_date,
        status,

        -- Useful derived fields
        date_part(year, created_at) as signup_year,
        date_part(month, created_at) as signup_month,
        case
            when status = 'active' then true
            else false
        end as is_active

    from {{ ref('stg_customers') }}

)

select * from customers
