{{ config(materialized='table') }}

with
    countryregion as (
        select
            countryregioncode as country_region_code,
            name as country_region_name,
            modifieddate as modified_date
        from {{ source('adventure_works', 'countryregion') }}
    )

select *
from countryregion