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
        from {{ ref('stg__sales') }}
    )

select *
from salesorderheader