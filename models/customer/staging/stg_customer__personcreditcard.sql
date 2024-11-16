with
    personcreditcard as (
        select 
            businessentityid
            , creditcardid
            from {{ source('customers', 'personcreditcard') }}
    )
select * 
from personcreditcard