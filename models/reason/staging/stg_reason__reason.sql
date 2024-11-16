with
    salesreason as (
        select 
            salesreasonid
            , reasontype
            from {{ source('reason', 'salesreason') }}
    )
select * 
from salesreason