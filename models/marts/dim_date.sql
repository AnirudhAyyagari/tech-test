{{ config(
    materialized='table',
    tags=["marts"]
) }}


with dates as (
    -- Select distinct dates from the stg_survey_data table
    select distinct
        date_trunc('day', survey_month) as date_key
    from 
        {{ ref('stg_survey_data') }}
)

select
    to_char(date_key, 'YYYYMMDD')::integer as date_key,
    date_key::date as survey_month,
    extract(day from date_key) as day,
    extract(month from date_key) as month,
    extract(year from date_key) as year,
    extract(quarter from date_key) as quarter,
    extract(week from date_key) as week,
    extract(dow from date_key) as day_of_week
from 
    dates
order by 
    date_key
