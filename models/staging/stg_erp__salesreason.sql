{{ config(materialized='table') }}

with
    salesreason as (
        select
            name,
            salesreasonid as sales_reason_id,
            reasontype as reason_type,
            modifieddate as modified_date
        from {{ source('adventure_works', 'salesreason') }}
    )

select *
from salesreason
