-- test_awareness_percentage_sum.sql

with monthly_sums as (
    select
        date_key,
        sum(awareness_percentage) as total_awareness_percentage,
        brand_id
    from
        {{ ref('fact_brand_summary') }}
    group by
        date_key
)

select
    date_key
from
    monthly_sums

where
    total_awareness_percentage > 100

group by 
    brand_id
