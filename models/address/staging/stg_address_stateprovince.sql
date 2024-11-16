with 
    stateprovince as (
        select 
            stateprovinceid
            , countryregioncode
            , name as state
            from {{ source('address', 'stateprovince') }}
    )

select * 
from stateprovince