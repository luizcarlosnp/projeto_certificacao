with
    cards as (
        select *
        from {{ ref('int_cards') }}
    )

select *
from cards