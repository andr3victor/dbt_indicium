with 
    country as (
        select
            countryregioncode
            , name as country
            from {{ source('address', 'countryregion') }}
    )

select * 
from country