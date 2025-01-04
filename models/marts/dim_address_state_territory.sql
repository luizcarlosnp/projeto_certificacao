with
    address_state_territory as (
        select *
        from {{ ref('int_address_state_territory') }}
    )

select *
from address_state_territory