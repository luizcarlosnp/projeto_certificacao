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
            creditcard.creditcardid as credit_card_id,
            creditcard.cardtype as card_type,
            creditcard.expmonth as expiration_month,
            creditcard.expyear as expiration_year,
            personcreditcard.businessentityid as business_entity_id
        from 
            creditcard 
        left join  
            personcreditcard
        on 
            creditcard.creditcardid = personcreditcard.creditcardid
    )
    select * from joined