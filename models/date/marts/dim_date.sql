with final as (
    select distinct
        cast(orderdate as date) as date_sk
        , extract(year from cast(orderdate as date)) as year
        , extract(month from cast(orderdate as date)) as month
    from {{ ref('stg__sales') }}
)
select *
from final




