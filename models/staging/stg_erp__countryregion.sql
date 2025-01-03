{{ config(materialized='table') }}

with
    countryregion as (
        select *
        from {{ source('adventure_works', 'countryregion') }}
    )

select *
from countryregion