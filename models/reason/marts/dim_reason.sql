with reason_pivot as (
    select 
        stg_reason__reasonsales.salesorderid
        , max(case when stg_reason__reason.reasontype = 'Other' then stg_reason__reason.reasontype end) as other_reason
        , max(case when stg_reason__reason.reasontype = 'Marketing' then stg_reason__reason.reasontype end) as marketing_reason
        , max(case when stg_reason__reason.reasontype = 'Promotion' then stg_reason__reason.reasontype end) as promotion_reason
    from {{ ref('stg_reason__reasonsales') }} as stg_reason__reasonsales
    left join {{ ref('stg_reason__reason') }} as stg_reason__reason
        on stg_reason__reasonsales.salesreasonid = stg_reason__reason.salesreasonid
    group by 
        stg_reason__reasonsales.salesorderid
)
, final as (
    select 
        salesorderid as salesreasonid
        , coalesce(other_reason, '') as other_reason
        , coalesce(marketing_reason, '') as marketing_reason
        , coalesce(promotion_reason, '') as promotion_reason
        , case 
            when other_reason = '' and marketing_reason = '' and promotion_reason = '' then null
            else
                -- Concatenar valores com vírgulas, mas somente quando as razões não estiverem vazias
                concat(
                    case when other_reason != '' then other_reason else '' end,
                    case when other_reason != '' and marketing_reason != '' then ', ' else '' end,
                    case when marketing_reason != '' then marketing_reason else '' end,
                    case when (marketing_reason != '' or other_reason != '') and promotion_reason != '' then ', ' else '' end,
                    case when promotion_reason != '' then promotion_reason else '' end
                )
        end as reason_list
    from reason_pivot
)
select *
from final
