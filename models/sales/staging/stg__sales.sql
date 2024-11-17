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
        from {{ source('sales', 'salesorderheader') }}
    )

select *
from salesorderheader