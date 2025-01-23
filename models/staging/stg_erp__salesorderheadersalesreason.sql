{{ config(materialized='table') }}

with
    salesorderheadersalesreason as (
        select
            salesorderid as sales_order_id,
            salesreasonid as sales_reason_id,
            modifieddate as modified_date
        from {{ source('adventure_works', 'salesorderheadersalesreason') }}
    )

select *
from salesorderheadersalesreason
