with reason_pivot as (
    select 
        stg_reason__reasonsales.salesorderid
        , max(case when stg_reason__reason.reasontype = 'Other' then stg_reason__reason.reasontype end) as other_reason
        , max(case when stg_reason__reason.reasontype = 'Marketing' then stg_reason__reason.reasontype end) as marketing_reason
        , max(case when stg_reason__reason.reasontype = 'Promotion' then stg_reason__reason.reasontype end) as promotion_reason
    from stg_reason__reasonsales
    left join stg_reason__reason
        on stg_reason__reasonsales.salesreasonid = stg_reason__reason.salesreasonid
    group by 
        stg_reason__reasonsales.salesorderid
)
select 
    salesorderid
    , coalesce(other_reason, '') as other_reason
    , coalesce(marketing_reason, '') as marketing_reason
    , coalesce(promotion_reason, '') as promotion_reason
from reason_pivot

