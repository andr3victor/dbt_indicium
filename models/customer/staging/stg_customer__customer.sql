with
    customers as (
        select 
            customerid
            , personid
            from {{ source('customers', 'customer') }}
    )
select * 
from customers