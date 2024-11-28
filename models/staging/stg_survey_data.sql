{{ config(
    materialized='table',
    tags=["stage"]
) }}

select
    distinct
        cast(data->>'RESPONDENT_ID' as bigint) as respondent_id,
        cast(data->>'RESPONDENT_WEIGHT' as numeric(10, 3)) as respondent_weight,
        cast(data->>'SURVEY_MONTH' as date) as survey_month,
        lower(cast(data->>'QUESTION_TYPE' as varchar(50))) as question_type,
        cast(data->>'SELECTED_BRAND_ID' as bigint) as selected_brand_id,
        lower(cast(data->>'SELECTED_BRAND_NAME' as varchar(50))) as selected_brand_name,
        cast(data->>'CATEGORY_ID' as bigint) as category_id,
        lower(cast(data->>'CATEGORY_NAME' as varchar(10))) as category_name
from
    {{ source('survey_data','raw_survey_data') }}





