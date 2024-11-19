with
    salesreason_tb as (
        select 
            salesreasonid
            , reasontype
            from {{ ref('stg_reason__reason') }}
    )

select *
from salesreason_tb