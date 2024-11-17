with 
    final as (
        select 
            creditcardid
            , cardtype
            from {{ ref('stg__creditcard') }}
    )

select * 
from final