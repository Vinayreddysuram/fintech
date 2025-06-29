{% snapshot stg_employees_scd2 %}
{{
    config(
        target_schema = 'staging_dev',
        unique_key = 'employee_id', 
        strategy = 'check',
        check_cols = ['name', 'email'],
        name= 'stg_employees_scd2'
    )
}}

select
    id as employee_id,    
    name as name,     
    email,
    uploaded_at
from {{ source('mysource', 'employees') }}

{% endsnapshot %}
