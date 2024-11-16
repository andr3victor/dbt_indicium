with
    person as (
        select 
            businessentityid
            , firstname
            , lastname
            from {{ source('customers', 'person') }}
    )
select * 
from person