{{ config(materialized='table') }}

with address as (
    select
        address_id,
        address_line_1,
        address_line_2,
        city,
        state_province_id,
        postal_code,
        spatial_location,
        row_guid
    from {{ ref('stg_erp__address') }}
),
stateprovince as (
    select
        state_province_id,
        state_province_code,
        country_region_code,
        is_only_state_province_flag,
        state_province_name,
        territory_id,
        row_guid
    from {{ ref('stg_erp__stateprovince') }}
),
salesterritory as (
    select
        territory_id,
        territory_name,
        country_region_code,
        sales_ytd,
        sales_last_year,
        cost_ytd,
        cost_last_year,
        row_guid
    from {{ ref('stg_erp__salesterritory') }}
),
joined as (
    select
        address.address_id,
        address.address_line_1,
        address.address_line_2,
        address.city,
        address.postal_code,
        address.spatial_location,
        stateprovince.state_province_code,
        stateprovince.state_province_name,
        salesterritory.territory_name,
        salesterritory.territory_id,
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
        stateprovince.territory_id = salesterritory.territory_id
)

select * from joined
