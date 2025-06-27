{{ config(
    schema='marts_dev',
    materialized:'table'

) }}

select
  payment_id,
  customer_id,
  amount,
  status,
  payment_method,
  paid_at::date as payment_date,
  date_trunc('month', paid_at) as payment_month,
  case when status = 'success' then 1 else 0 end as is_successful,
  case when status != 'success' then 1 else 0 end as is_failed
from {{ ref('stg_payments') }}
