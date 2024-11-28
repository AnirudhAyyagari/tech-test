{{ config(
    materialized='table',
    tags=["stage"]
) }}

select 
    cast(data->>'brand_id' as bigint) as brand_id,
    lower(split_part(data->>'headquarters_location', ',', 1))::varchar(50) as city,
    lower(trim(split_part(data->>'headquarters_location', ',', 2)))::varchar(50) as country,
    lower(cast(data->>'brand_tier' as varchar(30))) as brand_tier
from
    {{ source('survey_data', 'raw_brand_information') }}

