with 
header as (
    select * from {{ ref('stg_erp__salesorderheader') }}
),
details as (
    select * from {{ ref('stg_erp__salesorderdetail') }}
),
addresses as (
    select
        addressid,
        city,
        stateprovinceid,
        postalcode,
        modifieddate
    from
        {{ ref('stg_erp__address') }}
),
joined as (
    select
        header.salesorderid as pedido_id,
        cast(header.orderdate as date) as data_pedido,
        header.customerid as cliente_id,
        header.territoryid as territorio_id,
        header.billtoaddressid as endereco_cobranca_id,
        header.shiptoaddressid as endereco_entrega_id,
        header.shipmethodid as metodo_envio_id,
        header.subtotal as valor_subtotal,
        header.taxamt as valor_imposto,
        header.freight as valor_frete,
        header.comment as comentario,
        header.status,
        header.modifieddate as data_modificacao_cabecalho,
        details.salesorderdetailid as detalhe_pedido_id,
        details.productid as produto_id,
        details.specialofferid as oferta_especial_id,
        details.orderqty as quantidade_pedido,
        details.unitprice as preco_unitario,
        details.unitpricediscount as desconto_unitario,
        details.modifieddate as data_modificacao_detalhe,
        addresses.city as cidade_entrega,
        addresses.stateprovinceid as estado_provincia_id,
        addresses.postalcode as codigo_postal_entrega
    from
        header
    inner join
        details
    on
        header.salesorderid = details.salesorderid
    left join
        addresses
    on
        header.shiptoaddressid = addresses.addressid
),
metrics as (
    select 
        pedido_id,
        data_pedido,
        extract(year from data_pedido) as ano,
        extract(month from data_pedido) as mes,
        cliente_id,
        territorio_id,
        endereco_cobranca_id,
        endereco_entrega_id,
        metodo_envio_id,
        valor_subtotal,
        valor_imposto,
        valor_frete,
        comentario,
        status,
        data_modificacao_cabecalho,
        detalhe_pedido_id,
        produto_id,
        oferta_especial_id,
        quantidade_pedido,
        preco_unitario,
        desconto_unitario,
        quantidade_pedido * preco_unitario as valor_total_negociado,
        quantidade_pedido * preco_unitario as faturamento_bruto,
        quantidade_pedido * desconto_unitario as total_desconto,
        data_modificacao_detalhe,
        cidade_entrega,
        estado_provincia_id,
        codigo_postal_entrega
    from joined
)
select * from metrics