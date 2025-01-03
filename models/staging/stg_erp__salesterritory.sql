{{ config(materialized='table') }}

with
    salesterritory as (
        select *
        from {{ source('adventure_works', 'salesterritory') }}
    )

select *
from salesterritory