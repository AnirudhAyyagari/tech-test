{{ config(
    materialized='table',
    tags=["marts"]
) }}

select
    -- generating random guid as question id for model extension
    gen_random_uuid()::uuid as question_id,
    cast(question_type as varchar(10)) as question_type

from
    {{ ref('stg_survey_data') }}