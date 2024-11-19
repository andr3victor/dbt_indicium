with
    salesorderheadersalesreason as (
        select  
            salesorderid
            , salesreasonid
            from {{ ref('stg_reason__reasonsales') }}
    )
select * 
from salesorderheadersalesreason