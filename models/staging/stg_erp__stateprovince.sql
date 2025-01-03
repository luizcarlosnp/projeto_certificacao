{{ config(materialized='table') }}

with
    stateprovince as (
        select *
        from {{ source('adventure_works', 'stateprovince') }}
    )

select *
from stateprovince