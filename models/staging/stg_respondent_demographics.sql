{{ config(
    materialized='table',
    tags=["stage"]
) }}

select 
    cast(data->>'respondent_id' as bigint) as respondent_id,
    lower(cast(data->>'Gender' as varchar(10))) as gender,
    cast(data->>'DateOfBirth' as date) as dateofbirth,
    lower(cast(data->>'Income' as varchar(10))) as income,
    lower(cast(data->>'Education' as varchar(20))) as education,
    lower(cast(data->>'City' as varchar(20))) as city,
    lower(cast(data->>'State' as varchar(20))) as "state",
    lower(cast(data->>'Country' as varchar(20))) AS country
from
    {{ source('survey_data','raw_respondent_demographics') }}

