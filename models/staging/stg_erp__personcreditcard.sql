{{ config(materialized='table') }}

with
    personcreditcard as (
        select
            businessentityid as business_entity_id,
            creditcardid as credit_card_id,
            modifieddate as modified_date
        from {{ source('adventure_works', 'personcreditcard') }}
    )

select *
from personcreditcard
