WITH 
header AS (
    SELECT * FROM {{ ref('stg_erp__salesorderheader') }}
),
details AS (
    SELECT * FROM {{ ref('stg_erp__salesorderdetail') }}
),
addresses AS (
    SELECT
        addressid,
        city,
        stateprovinceid,
        postalcode,
        modifieddate
    FROM
        {{ ref('stg_erp__address') }}
),
joined AS (
    SELECT
        header.salesorderid AS pedido_id,
        CAST(header.orderdate AS DATE) AS data_pedido,
        header.customerid AS cliente_id,
        header.territoryid AS territorio_id,
        header.billtoaddressid AS endereco_cobranca_id,
        header.shiptoaddressid AS endereco_entrega_id,
        header.shipmethodid AS metodo_envio_id,
        header.subtotal AS valor_subtotal,
        header.taxamt AS valor_imposto,
        header.freight AS valor_frete,
        header.comment AS comentario,
        header.modifieddate AS data_modificacao_cabecalho,
        details.salesorderdetailid AS detalhe_pedido_id,
        details.productid AS produto_id,
        details.specialofferid AS oferta_especial_id,
        details.orderqty AS quantidade_pedido,
        details.unitprice AS preco_unitario,
        details.unitpricediscount AS desconto_unitario,
        details.modifieddate AS data_modificacao_detalhe,
        addresses.city AS cidade_entrega,
        addresses.stateprovinceid AS estado_provincia_id,
        addresses.postalcode AS codigo_postal_entrega
    FROM
        header
    INNER JOIN
        details
    ON
        header.salesorderid = details.salesorderid
    LEFT JOIN
        addresses
    ON
        header.shiptoaddressid = addresses.addressid
)
SELECT * FROM joined;
