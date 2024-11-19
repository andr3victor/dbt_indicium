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
    salesorderdetail_agg as (
        select
            salesorderid
            , sum(unitprice * orderqty) as total_negotiated_value
            , sum(unitprice * orderqty * (1 - unitpricediscount)) as total_net_negotiated_value
            , count(distinct productid) as distinct_products_count
        from {{ ref('stg__salesorderdetail') }}
        group by salesorderid
    ),
    sales_data as (
        select
            {{ dbt_utils.generate_surrogate_key(['salesorderheader.salesorderid']) }} as sales_sk
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
            , salesorderdetail_agg.total_negotiated_value
            , salesorderdetail_agg.total_net_negotiated_value
            , salesorderdetail_agg.distinct_products_count
        from salesorderheader
        left join salesorderdetail_agg
            on salesorderheader.salesorderid = salesorderdetail_agg.salesorderid
    )

select *
from sales_data;
