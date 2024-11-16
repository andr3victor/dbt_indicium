with
    salesorderheader as (
        select
            salesorderid
            , shiptoaddressid
            , customerid
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