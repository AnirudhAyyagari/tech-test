{{ config(
    materialized='table',
    tags=["marts"]
) }}

select
    cast(category_id as bigint) as category_id,
    cast(category_name as varchar(30)) as category_name
from
    {{ ref('stg_survey_data') }}