with
    salesorderheader as (
        select
            salesorderid
            , shiptoaddressid
            , customerid
            , creditcardid
            , orderdate
            , duedate
            , shipdate
            , subtotal
            , taxamt
            , freight
            , totaldue
            , status
        from {{ source('sales', 'salesorderheader') }}
    )

select *
from salesorderheader