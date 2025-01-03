{{ config(materialized='table') }}

with
    customer as (
        select *
        from {{ source('adventure_works', 'customer') }}
    )

select *
from customer