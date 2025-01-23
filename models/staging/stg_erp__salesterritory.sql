{{ config(materialized='table') }}

with
    salesterritory as (
        select
            territoryid as territory_id,
            name as territory_name,
            countryregioncode as country_region_code,
            salesytd as sales_ytd,
            saleslastyear as sales_last_year,
            costytd as cost_ytd,
            costlastyear as cost_last_year,
            rowguid as row_guid,
            modifieddate as modified_date
        from {{ source('adventure_works', 'salesterritory') }}
    )

select *
from salesterritory
