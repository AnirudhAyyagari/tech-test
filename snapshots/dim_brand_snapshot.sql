{% snapshot dim_brand_snapshot %}

    {{ 
        config(
            target_schema='datamartsp',
            unique_key='brand_id',
            strategy='check',
            check_cols=['brand_name', 'brand_tier', 'country', 'city']
            )
    }}

    select
       brand_id as brand_id,
       cast(brand_name as varchar(20)) as brand_name,
       cast(country as varchar(20)) as country,
       cast(city as varchar(20)) as city,
       cast(brand_tier as varchar(20)) as brand_tier

    from
        {{ ref('int_brand_information') }}

{% endsnapshot %}
