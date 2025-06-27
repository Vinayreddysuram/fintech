{{ config(
    schema='marts_dev',
    materialized= 'table'

) }}

with payments as (
  select
    customer_id,
    date_trunc('month', paid_at) as payment_month,
    sum(case when status = 'success' then amount else 0 end) as total_revenue,
    count(*) as num_payments,
    sum(case when status != 'success' then 1 else 0 end) as num_failed
  from {{ ref('stg_payments') }}
  group by customer_id, payment_month
)

select * from payments
