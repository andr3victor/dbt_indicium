with 
    address as (
        select 
            addressid
            , stateprovinceid
            , city
            from {{ source('address', 'address') }}
    )

select * 
from address