{{ config(materialized='table') }}

with
    salesreason as (
        select *
        from {{ source('adventure_works', 'salesreason') }}
    )

select *
from salesreason