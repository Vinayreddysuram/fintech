{{ config(
    materialized = 'incremental',
    unique_key = 'payment_id',
    schema = 'marts_dev'
) }}

select
    payment_id,
    customer_id,
    amount,
    status,
    payment_method,
    payment_date,
    payment_month,
    is_successful,
    is_failed
from {{ ref('stg_payments') }}

{% if is_incremental() %}
  where payment_date > (select max(payment_date) from {{ this }})
{% endif %}
