with
    employee as (
        select *
        from {{ source('adventure_works', 'employee') }}
    )

select *
from employee