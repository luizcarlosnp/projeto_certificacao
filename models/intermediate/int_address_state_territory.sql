{{ config(materialized='table') }}

with address as (
    select
        addressid as address_id,
        addressline1 as address_line1,
        addressline2 as address_line2,
        city as city_name,
        stateprovinceid as state_province_id,
        postalcode as postal_code,
        spatiallocation as location,
        rowguid as address_rowguid
    from {{ ref('stg_erp__address') }}
),
stateprovince as (
    select
        stateprovinceid as state_province_id,
        stateprovincecode as state_province_code,
        countryregioncode as country_region_code,
        isonlystateprovinceflag as is_only_state_province,
        name as state_province_name,
        territoryid as sales_territory_id,
        rowguid as state_province_rowguid
    from {{ ref('stg_erp__stateprovince') }}
),
salesterritory as (
    select
        territoryid as sales_territory_id,
        name as territory_name,
        countryregioncode as country_region_code,
        salesytd as sales_ytd,
        saleslastyear as sales_last_year,
        costytd as cost_ytd,
        costlastyear as cost_last_year,
        rowguid as territory_rowguid
    from {{ ref('stg_erp__salesterritory') }}
),
joined as (
    select
        address.address_id,
        address.address_line1,
        address.address_line2,
        address.city_name,
        address.postal_code,
        address.location,
        stateprovince.state_province_code,
        stateprovince.state_province_name,
        salesterritory.territory_name,
        salesterritory.sales_ytd,
        salesterritory.sales_last_year,
        salesterritory.cost_ytd,
        salesterritory.cost_last_year
    from address
    inner join 
        stateprovince
    on 
        address.state_province_id = stateprovince.state_province_id
    inner join 
        salesterritory
    on 
        stateprovince.sales_territory_id = salesterritory.sales_territory_id
)

select * from joined