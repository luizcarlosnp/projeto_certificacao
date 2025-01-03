{{ config(materialized='table') }}


with
    salesorderheadersalesreason as (
        select *
        from {{ source('adventure_works', 'salesorderheadersalesreason') }}
    )

select *
from salesorderheadersalesreason