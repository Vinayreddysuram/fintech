{{ config(schema='marts_dev') }}

select
  customer_id,
  name,
  email,
  created_at::date as signup_date,
  date_part(year, created_at) as signup_year,
  date_part(month, created_at) as signup_month
from {{ ref('stg_customers') }}
