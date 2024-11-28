{{ config(
    materialized='table',
    tags=["marts"]
)}}

select
    cast(sd.respondent_id as bigint) as respondent_id,

    -- Additional columns as a part of extension and completeness of the dataset
    cast(rd.gender as varchar(10)) as gender,
    cast(rd.income as varchar(10)) as income,
    cast(rd.dateofbirth as date) as dateofbirth,
    cast(rd.education as varchar(10)) as education,
    cast(rd.city as varchar(20)) as city,
    cast(rd.state as varchar(20)) as "state",
    cast(rd.country as varchar(20)) as country


from 
    {{ ref('stg_survey_data') }} sd

join
    {{ ref('stg_respondent_demographics') }} rd

on 
    sd.respondent_id = rd.respondent_id