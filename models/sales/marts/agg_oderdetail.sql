with final as (
    select 
        {{ 
            dbt_utils.generate_surrogate_key([
                'productid'
                , 'salesorderid'
            ]) 
        }} as orderdetail_sk
        , salesorderid
        , unitprice
        , unitpricediscount
        , orderqty
        , unitprice * orderqty as negotiatedvalue
        , unitprice * orderqty * (1 - unitpricediscount) as netnegotiatedvalue
    from {{ ref('stg__salesorderdetail') }}
)
select *
from final
