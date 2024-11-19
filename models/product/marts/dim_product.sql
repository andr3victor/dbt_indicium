with
    product_tb as (
        select
            productid
          , product
        from {{ ref('stg_product__product') }}
    )

select *
from product_tb
