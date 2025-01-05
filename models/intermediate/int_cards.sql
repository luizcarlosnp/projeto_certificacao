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
            creditcard.creditcardid as creditcard_id,
            creditcard.cardtype as tipo_cartao,
            creditcard.expmonth as mes_expiracao,
            creditcard.expyear as ano_expiracao,
            personcreditcard.businessentityid as entidade_negocio_id
        from 
            creditcard 
        left join  
            personcreditcard
        on 
            creditcard.creditcardid = personcreditcard.creditcardid
    )
    select * from joined
