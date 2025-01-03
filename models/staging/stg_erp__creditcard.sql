{{ config(materialized='table') }}

with
    creditcard as (
        select *
        from {{ source('adventure_works', 'creditcard') }}
    )

select *
from creditcard