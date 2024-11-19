with
    salesorderdetail as (
     select 
        productid
        , salesorderid
        , unitprice
        , unitpricediscount
        , orderqty
        from {{ source('sales','salesorderdetail')}}
    )

select *
from salesorderdetail