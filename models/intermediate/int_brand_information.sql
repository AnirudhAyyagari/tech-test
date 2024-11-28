{{ config(
    materialized='table',
    tags=["intermediate"]
) }}


select
    distinct
        sd.selected_brand_id as brand_id,
        cast(sd.selected_brand_name as varchar(50)) as brand_name,

        -- Additional columns as a part of extension
        cast(bi.country as varchar(50)) as country,
        cast(bi.city as varchar(50)) as city,
        cast(bi.brand_tier as varchar(50)) as brand_tier

from
    {{ ref('stg_survey_data') }} as sd

join 
    {{ref('stg_brand_information')}} as bi

on
    sd.selected_brand_id = bi.brand_id
