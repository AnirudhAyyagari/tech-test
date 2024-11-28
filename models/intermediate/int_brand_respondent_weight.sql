{{ config(
    materialized='ephemeral',
    tags=["intermediate"]
) }}


with brand_respondent_weight as (
    select 
        selected_brand_id as brand_id,
    	cast(date_trunc('MONTH', survey_month) as date) as start_of_month,
        cast(sum(respondent_weight) as numeric(10,2)) as brand_total_respondent_weight
    from
        {{ ref('stg_survey_data') }}
    where 
        question_type = 'prompted awareness'
    group by 
        brand_id,
        start_of_month
)

select * from brand_respondent_weight
