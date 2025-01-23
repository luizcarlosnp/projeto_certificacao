{{ config(materialized='table') }}

with
    creditcard as (
        select * from {{ ref('stg_erp__creditcard') }}
    ), 
    personcreditcard as (
        select * from {{ ref('stg_erp__personcreditcard') }}
    ), 
    joined as (
        select 
            creditcard.creditcard_id
            creditcard.card_type,
            creditcard.exp_month,
            creditcard.exp_year,
            personcreditcard.business_entity_id
        from 
            creditcard 
        left join  
            personcreditcard
        on 
            creditcard.creditcardid = personcreditcard.creditcardid
    )
    select * from joined
