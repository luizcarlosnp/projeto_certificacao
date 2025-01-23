{{ config(materialized='table') }}

with 
header as (
    select * from {{ ref('stg_erp__salesorderheader') }}
),
details as (
    select * from {{ ref('stg_erp__salesorderdetail') }}
),
addresses as (
    select
        address_id,
        city,
        state_province_id,
        postal_code,
        modified_date
    from
        {{ ref('stg_erp__address') }}
),
salesorderheadersalesreason as (
    select * from {{ ref('stg_erp__salesorderheadersalesreason') }}
),
salesreason as (
    select * from {{ ref('stg_erp__salesreason') }}    
),
joined as (
    select 
        header.sales_order_id,
        cast(header.order_date as date) as order_date,
        header.customer_id,
        header.territory_id,
        header.bill_to_address_id,
        header.ship_to_address_id,
        header.ship_method_id,
        header.subtotal,
        header.tax_amount,
        header.freight,
        header.comment,
        header.status,
        header.credit_card_id,
        details.sales_order_detail_id,
        details.product_id,
        details.special_offer_id,
        details.order_quantity,
        details.unit_price,
        details.unit_price_discount,
        addresses.city,
        addresses.state_province_id,
        addresses.postal_code,
        salesreason.reason_type
    from
        header
    inner join
        details
    on
        header.sales_order_id = details.sales_order_id
    left join
        addresses
    on
        header.ship_to_address_id = addresses.address_id
    left join 
        salesorderheadersalesreason
    on
        header.sales_order_id = salesorderheadersalesreason.sales_order_id
    left join
        salesreason
    on
        salesorderheadersalesreason.sales_reason_id = salesreason.sales_reason_id
),
metrics as (
    select distinct
        sales_order_id as order_id,
        order_date,
        extract(year from order_date) as year,
        extract(month from order_date) as month,
        customer_id,
        territory_id,
        bill_to_address_id as billing_address_id,
        ship_to_address_id as shipping_address_id,
        ship_method_id as shipping_method_id,
        subtotal,
        tax_amount,
        freight,
        comment,
        status,
        credit_card_id,
        sales_order_detail_id as order_detail_id,
        product_id,
        special_offer_id,
        order_quantity,
        unit_price,
        unit_price_discount as unit_discount,
        order_quantity * unit_price as total_deal_value,
        order_quantity * unit_price as gross_revenue,
        order_quantity * unit_price_discount as total_discount,
        city as shipping_city,
        state_province_id as shipping_state_province_id,
        postal_code as shipping_postal_code,
        reason_type
    from joined
)
select * from metrics
