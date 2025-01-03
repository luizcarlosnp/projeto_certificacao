{{ config(materialized='table') }}

with
    address as (
        select *
        from {{ source('adventure_works', 'address') }}
    )

select *
from address