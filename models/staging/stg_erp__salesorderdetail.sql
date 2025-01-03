{{ config(materialized='table') }}

with
    salesorderdetail as (
        select *
        from {{ source('adventure_works', 'salesorderdetail') }}
    )

select *
from salesorderdetail