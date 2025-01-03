{{ config(materialized='table') }}

with
    personcreditcard as (
        select *
        from {{ source('adventure_works', 'personcreditcard') }}
    )

select *
from personcreditcard