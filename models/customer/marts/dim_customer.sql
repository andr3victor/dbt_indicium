with 
    final as (
        select
            customerid
            , customer
        from {{ ref('int_customer__names') }} 
    )
select *
from final
