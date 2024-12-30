with
    salesperson as (
        select *
        from {{ source('adventure_works', 'salesperson') }}
    )

select *
from salesperson