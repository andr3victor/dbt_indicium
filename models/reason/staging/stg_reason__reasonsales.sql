with
    salesorderheadersalesreason as (
        select  
            salesorderid
            , salesreasonid
            from {{ source('reason', 'salesorderheadersalesreason') }}
    )
select * 
from salesorderheadersalesreason