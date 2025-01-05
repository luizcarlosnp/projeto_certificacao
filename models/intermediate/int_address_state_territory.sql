{{ config(materialized='table') }}

with address as (
    select
        addressid as endereco_id,
        addressline1 as linha_endereco1,
        addressline2 as linha_endereco2,
        city as nome_cidade,
        stateprovinceid as estado_provincia_id,
        postalcode as codigo_postal,
        spatiallocation as localizacao,
        rowguid as endereco_rowguid
    from {{ ref('stg_erp__address') }}
),
stateprovince as (
    select
        stateprovinceid as estado_provincia_id,
        stateprovincecode as codigo_estado_provincia,
        countryregioncode as codigo_pais_regiao,
        isonlystateprovinceflag as flag_apenas_estado_provincia,
        name as nome_estado_provincia,
        territoryid as territorio_id,
        rowguid as estado_provincia_rowguid
    from {{ ref('stg_erp__stateprovince') }}
),
salesterritory as (
    select
        territoryid as territorio_id,
        name as nome_territorio,
        countryregioncode as codigo_pais_regiao,
        salesytd as vendas_ano_atual,
        saleslastyear as vendas_ano_anterior,
        costytd as custo_ano_atual,
        costlastyear as custo_ano_anterior,
        rowguid as territorio_rowguid
    from {{ ref('stg_erp__salesterritory') }}
),
joined as (
    select
        address.endereco_id,
        address.linha_endereco1,
        address.linha_endereco2,
        address.nome_cidade,
        address.codigo_postal,
        address.localizacao,
        stateprovince.codigo_estado_provincia,
        stateprovince.nome_estado_provincia,
        salesterritory.nome_territorio,
        salesterritory.territorio_id,
        salesterritory.vendas_ano_atual,
        salesterritory.vendas_ano_anterior,
        salesterritory.custo_ano_atual,
        salesterritory.custo_ano_anterior
    from address
    inner join 
        stateprovince
    on 
        address.estado_provincia_id = stateprovince.estado_provincia_id
    inner join 
        salesterritory
    on 
        stateprovince.territorio_id = salesterritory.territorio_id
)

select * from joined
