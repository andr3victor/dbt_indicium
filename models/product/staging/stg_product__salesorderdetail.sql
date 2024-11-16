with
    salesorderdetail as (
     select 
        productid
        , salesorderid
        , unitprice
        , orderqty
from salesorderdetail
        from {{ source('products','salesorderdetail')}}
    )

select *
from salesorderdetail