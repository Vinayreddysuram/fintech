{{ config(
    schema = 'marts_dev',
    materialized = 'table'
) }}

with base as (

  select
    customer_id,
    payment_month,
    amount,
    status

  from {{ ref('stg_payments') }}

),

aggregated as (

  select
    customer_id,
    payment_month,
    
    -- Total revenue from successful payments
    sum(case when status = 'success' then amount else 0 end) as total_revenue,
    
    -- Total number of payments (any status)
    count(*) as total_payments,

    -- Failed payments only
    sum(case when status != 'success' then 1 else 0 end) as failed_payments

  from base
  group by customer_id, payment_month

)

select * from aggregated
