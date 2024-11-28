{{ config(
    materialized='ephemeral',
    tags=["intermediate"]

) }}


with unique_respondent_weights as (
    select
        respondent_id,
        cast(date_trunc('MONTH', survey_month) as date) as start_of_month,
        max(respondent_weight) as respondent_weight
    from
        {{ ref('stg_survey_data') }}
    where
        question_type = 'prompted awareness'
    group by
        respondent_id,
        start_of_month
),
total_respondent_weight as (
    select
        start_of_month,
        cast(sum(respondent_weight) as numeric(10,2)) as total_respondent_weight
    from
        unique_respondent_weights
    group by
        start_of_month
)
select * from total_respondent_weight
