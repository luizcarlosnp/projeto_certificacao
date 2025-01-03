{{ config(materialized='table') }}

with 
-- Tabela base de clientes
customers as (
    select
        customerid as cliente_id,
        personid as pessoa_id,
        storeid as loja_id,
        territoryid as territorio_id,
        rowguid as identificador_global_cliente
    from {{ ref('stg_erp__customer') }}
),
-- Informações de pessoas associadas aos clientes
persons as (
    select
        businessentityid as pessoa_id,
        firstname as primeiro_nome,
        middlename as nome_do_meio,
        lastname as sobrenome,
        emailpromotion as participa_promocoes_email
    from {{ ref('stg_erp__person') }}
),
-- Informações de endereço
addresses as (
    select
        addressid as endereco_id,
        city as cidade,
        stateprovinceid as estado_id,
        postalcode as codigo_postal
    from {{ ref('stg_erp__address') }}
),
-- Informações sobre estados ou províncias
state_provinces as (
    select
        stateprovinceid as estado_id,
        name as estado_nome,
        countryregioncode as codigo_pais
    from {{ ref('stg_erp__stateprovince') }}
),
-- Informações sobre regiões e países
countries as (
    select
        countryregioncode as codigo_pais,
        name as pais_nome
    from {{ ref('stg_erp__countryregion') }}
),
-- Junta todas as informações para criar tabela intermediaria de clientes
joined as (
    select
        customers.cliente_id,
        persons.primeiro_nome,
        persons.nome_do_meio,
        persons.sobrenome,
        customers.loja_id,
        customers.territorio_id,
        addresses.cidade,
        state_provinces.estado_nome as estado,
        countries.pais_nome as pais,
        addresses.codigo_postal,
        persons.participa_promocoes_email,
        customers.identificador_global_cliente
    from 
        customers
    left join 
        persons on customers.pessoa_id = persons.pessoa_id
    left join 
        addresses on customers.cliente_id = addresses.endereco_id
    left join 
        state_provinces on addresses.estado_id = state_provinces.estado_id
    left join 
        countries on state_provinces.codigo_pais = countries.codigo_pais
)
select * from joined
