{{ config(materialized='table') }}

with 
product as (
        select
            product_name,
            product_id,
            product_number,
             make_flag,
            finished_goods_flag,
            color,
            safety_stock_level,
            reorder_point,
            standard_cost,
            list_price,
            size,
            size_unit_measure_code,
            weight_unit_measure_code,
            weight,
            days_to_manufacture,
            product_line,
            class,
            style,
            product_subcategory_id,
            product_model_id,
            sell_start_date,
            sell_end_date,
            discontinued_date,
            row_guid,
            modified_date
    from {{ ref('stg_erp__product') }}
)

select * from product