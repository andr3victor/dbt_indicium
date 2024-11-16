with
    salesorderdetail as (
     select 
        productid
        , salesorderid
        , unitprice
        , orderqty
        from {{ source('products','salesorderdetail')}}
    )

select *
from salesorderdetail