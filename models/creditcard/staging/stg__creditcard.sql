with 
    creditcard as (
        select 
            creditcardid
            , cardtype
            from {{ source('creditcard', 'creditcard') }}
    )

select * 
from creditcard