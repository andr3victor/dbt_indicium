with 
    customer_name as (
        select 
            customer_tb.customerid
            , concat(person.firstname, ' ', person.lastname) as customer 
        from {{ ref('stg_customer__person') }} as person
        left join {{ ref('stg_customer__customer') }} as customer_tb
            on customer_tb.personid = person.businessentityid
    )
select *
from customer_name
where customerid is not null



