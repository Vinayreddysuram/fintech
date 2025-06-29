{{
     config(
        materialized='incremental',
        schema='staging_dev',
        unique_key= 'emp_id',
     )
}}

select 

id as emp_id,
name as emp_name,
email as emp_email,
uploaded_at as uploaded_at
from {{ source('mysource','employees' )}}
{% if is_incremental() %}
where uploaded_at > (select max(uploaded_at) from {{this}})
{% endif %}