with
    address_tb as (
        select 
            addressid
            , stateprovinceid
            , city
        from {{ ref('stg_address__address') }}
    ),

    stateprovince_tb as (
        select 
            stateprovinceid
            , countryregioncode
            , state
        from {{ ref('stg_address_stateprovince') }}
    ),

    country_tb as (
        select
            countryregioncode
            , country
        from {{ ref('stg_address__country') }}
    ),

    join_tables as (
        select
            address_tb.addressid
            , address_tb.city
            , stateprovince_tb.state
            , country_tb.country
        from address_tb
        left join stateprovince_tb 
            on stateprovince_tb.stateprovinceid = address_tb.stateprovinceid
        left join country_tb 
            on country_tb.countryregioncode = stateprovince_tb.countryregioncode
    )

select * 
from join_tables
