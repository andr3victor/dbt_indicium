with
    salesorderheader as (
        select
            salesorderid
            , shiptoaddressid
            , customerid
            , creditcardid
            , cast(orderdate as date) as orderdate
            , cast(duedate as date) as duedate
            , cast(shipdate as date) as shipdate
            , subtotal
            , taxamt
            , freight
            , totaldue
            , status
        from {{ ref('stg__sales') }}
    )

select *
from salesorderheader
