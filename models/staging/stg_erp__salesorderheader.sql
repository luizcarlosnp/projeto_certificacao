{{ config(materialized='table') }}

with
    salesorderheader as (
        select *
        from {{ source('adventure_works', 'salesorderheader') }}
    )

select *
from salesorderheader