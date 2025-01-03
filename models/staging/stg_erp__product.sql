{{ config(materialized='table') }}

with
    product as (
        select *
        from {{ source('adventure_works', 'product') }}
    )

select *
from product