{{ config(
    materialized='table',
    tags=["marts"]
) }}


select
    {{ dbt_utils.generate_surrogate_key(['bw.brand_id', 'date_trunc(\'month\', bw.start_of_month)']) }} as id,
    cast(bw.brand_id as bigint) as brand_id,
    cast(to_char(bw.start_of_month, 'YYYYMMDD') as integer) as date_key,

    -- Handles division by zero and calculates awareness percentage, rounded up to the nearest integer
    case
        when tw.total_respondent_weight = 0 then 0
        else cast((bw.brand_total_respondent_weight / tw.total_respondent_weight) * 100 as numeric(10, 1))
    end as awareness_percentage,

    -- Calculates 3 months rolling average while handling zero values
    cast(
        avg(
            case
                when tw.total_respondent_weight = 0 then 0
                else (bw.brand_total_respondent_weight / tw.total_respondent_weight) * 100
            end
        ) over (
            partition by bw.brand_id
            order by bw.start_of_month
            rows between 2 preceding and current row
        ) as numeric(10, 1)
        ) as rolling_avg_3_months
from
    {{ ref('int_brand_respondent_weight') }} bw
join
    {{ ref('int_total_respondent_weight') }} tw
on 
    to_char(bw.start_of_month, 'YYYYMMDD') = to_char(tw.start_of_month, 'YYYYMMDD')