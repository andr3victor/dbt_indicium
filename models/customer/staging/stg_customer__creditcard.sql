with 
    creditcard as (
        select 
            creditcardid
            , cardtype
            from {{ source('customers', 'creditcard') }}
    )

select * 
from creditcard