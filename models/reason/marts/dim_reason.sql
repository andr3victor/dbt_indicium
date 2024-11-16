with
    salesorderheadersalesreason_tb as (
        select  
            salesorderid
            , salesreasonid
            from {{ ref('stg_reason__reasonsales') }}
    )

    , salesreason_tb as (
        select 
            salesreasonid
            , reasontype
            from {{ ref('stg_reason__reason') }}
    )

    , join_tables as (
        select
             {{ 
                dbt_utils.generate_surrogate_key([
                   'salesorderheadersalesreason_tb.salesorderid'
                   , 'salesreason_tb.reasontype'
                   , 'salesreason_tb.salesreasonid'
                ]) 
            }} as id_reason_sk
            , salesorderheadersalesreason_tb.salesorderid
            , salesreason_tb.reasontype
        from salesorderheadersalesreason_tb
        left join salesreason_tb 
        on salesorderheadersalesreason_tb.salesreasonid = salesreason_tb.salesreasonid
    )

select * 
from join_tables
