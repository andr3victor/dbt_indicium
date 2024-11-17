with
    product_tb as (
        select
            productid
          , product
        from {{ ref('stg_product__product') }}
    ),

    salesorderdetail_tb as (
        select
            productid
          , salesorderid
          , unitprice
          , unitpricediscount
          , orderqty
        from {{ ref('stg_product__salesorderdetail') }}
    ),

    join_tables as (
        select
            {{ 
                dbt_utils.generate_surrogate_key([
                    'product_tb.productid',
                    'salesorderdetail_tb.salesorderid'
                ]) 
            }} as product_sk
          , product_tb.productid
          , salesorderdetail_tb.salesorderid
          , product_tb.product
          , salesorderdetail_tb.unitprice
          , salesorderdetail_tb.unitpricediscount
          , salesorderdetail_tb.orderqty
          , (salesorderdetail_tb.unitprice * salesorderdetail_tb.orderqty) as negotiatedvalue
          , (salesorderdetail_tb.unitprice * salesorderdetail_tb.orderqty * (1 - salesorderdetail_tb.unitpricediscount)) as netnegotiatedvalue
        from product_tb
        left join salesorderdetail_tb 
          on product_tb.productid = salesorderdetail_tb.productid
    )

select *
from join_tables
