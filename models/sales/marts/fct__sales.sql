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
    ),
    salesorderdetail as (
        select 
            productid
            , salesorderid
            , unitprice
            , unitpricediscount
            , orderqty
            , (unitprice * orderqty) as negotiatedvalue
            , (unitprice * orderqty * (1 - unitpricediscount)) as netnegotiatedvalue
        from {{ ref('stg__salesorderdetail') }}
    ),
    salesorderheadersalesreason as (
        select  
            salesorderid
            , salesreasonid
        from {{ source('reason', 'salesorderheadersalesreason') }}
    ),
    sales_data as (
        select
            {{ 
                dbt_utils.generate_surrogate_key([
                    'salesorderdetail.productid',
                    'salesorderheader.salesorderid'
                ]) 
            }} as sales_sk
            , salesorderheader.salesorderid
            , salesorderheader.shiptoaddressid
            , salesorderheader.customerid
            , salesorderheader.creditcardid
            , salesorderheader.orderdate
            , salesorderheader.duedate
            , salesorderheader.shipdate
            , salesorderheader.subtotal
            , salesorderheader.taxamt
            , salesorderheader.freight
            , salesorderheader.totaldue
            , salesorderheader.status
            , salesorderdetail.productid
            , salesorderdetail.unitprice
            , salesorderdetail.unitpricediscount
            , salesorderdetail.orderqty
            , salesorderdetail.negotiatedvalue
            , salesorderdetail.netnegotiatedvalue
            , salesorderheadersalesreason.salesreasonid
        from salesorderheader
        left join salesorderdetail 
            on salesorderheader.salesorderid = salesorderdetail.salesorderid
        left join salesorderheadersalesreason 
            on salesorderheader.salesorderid = salesorderheadersalesreason.salesorderid
    )

select *
from sales_data
