{{ config(materialized='table') }}

with
    person as (
        select *
        from {{ source('adventure_works', 'person') }}
    )

select *
from person