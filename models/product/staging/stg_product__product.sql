with
    product_tb as (
        select
            productid
            , name as product
        from {{ source('products','product')}}
    )

select *
from product_tb