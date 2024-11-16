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
        from {{ ref('stg__sales') }}
    )

select *
from salesorderheader