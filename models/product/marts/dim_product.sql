with
    product_tb as (
        select
            productid
            , product
        from {{ ref('stg_product__product')}}
    )

    , salesorderdetail_tb as (
        select 
            productid
            , salesorderid
            , unitprice
            , orderqty
        from {{ ref('stg_product__salesorderdetail')}}
    )

    , join_tables as (
        select
            product_tb.productid
            , salesorderdetail_tb.salesorderid
            , product_tb.product
            , salesorderdetail_tb.unitprice
            , salesorderdetail_tb.orderqty
        from product_tb
        left join salesorderdetail_tb on product_tb.productid = salesorderdetail_tb.productid
    )

select *
from join_tables