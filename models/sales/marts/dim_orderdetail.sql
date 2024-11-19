with
    salesorderdetail as (
     select 
        productid
        , salesorderid
        , unitprice
        , unitpricediscount
        , orderqty
        , (unitprice * orderqty) as negotiatedvalue
        , (unitprice * orderqty * (1 - unitpricediscount)) as netnegotiatedvalue
        from {{ ref('stg__salesorderdetail')}}
    )

select *
from salesorderdetail



