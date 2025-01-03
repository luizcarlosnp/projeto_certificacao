{{ config(materialized='table') }}

with produtos as (
    -- Seleciona dados da tabela staging e aplica transformações
    select
        productid as produto_id,
        name as nome_produto,
        productnumber as numero_produto,
        makeflag as fabricado_internamente,
        finishedgoodsflag as produto_acabado,
        color as cor_produto,
        safetystocklevel as estoque_seguranca,
        reorderpoint as ponto_reabastecimento,
        standardcost as custo_padrao,
        listprice as preco_venda,
        size as tamanho_produto,
        sizeunitmeasurecode as unidade_medida_tamanho,
        weightunitmeasurecode as unidade_medida_peso,
        weight as peso_produto,
        daystomanufacture as dias_fabricacao,
        productline as linha_produto,
        class as classe_produto,
        style as estilo_produto,
        productsubcategoryid as id_subcategoria_produto,
        productmodelid as id_modelo_produto,
        sellstartdate as data_inicio_venda,
        sellenddate as data_fim_venda,
        discontinueddate as data_descontinuacao,
        rowguid as guid

    from stg_erp__product
)
-- Criação da tabela intermediaria de produtos
select
    produto_id,
    nome_produto,
    numero_produto,
    fabricado_internamente,
    produto_acabado,
    cor_produto,
    estoque_seguranca,
    ponto_reabastecimento,
    custo_padrao,
    preco_venda,
    tamanho_produto,
    unidade_medida_tamanho,
    unidade_medida_peso,
    peso_produto,
    dias_fabricacao,
    linha_produto,
    classe_produto,
    estilo_produto,
    id_subcategoria_produto,
    id_modelo_produto,
    data_inicio_venda,
    data_fim_venda,
    data_descontinuacao,
    guid
from produtos