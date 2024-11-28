{{ config(
    materialized='table',
    tags=["marts"]
) }}


select

    cast(sd.selected_brand_id as bigint) as brand_id,
    cast(sd.respondent_id as bigint) as respondent_id,
    cast(sd.respondent_weight as numeric(10,3)) as respondent_weight,
    cast(sd.category_id as bigint) as category_id,
    cast(dd.date_key as integer) as date_key

from
    {{ ref('stg_survey_data') }} sd

join
    {{ ref('dim_date') }} dd
on
    sd.survey_month = dd.survey_month

