with
    salesorderdetail as (
     select 
        productid
        , salesorderid
        , unitprice
        , unitpricediscount
        , orderqty
        from {{ source('products','salesorderdetail')}}
    )

select *
from salesorderdetail