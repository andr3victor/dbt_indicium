with 
    final as (
        select
            int_customer__names.customerid
            , int_customer__creditcard.creditcardid
            , int_customer__names.customer
        from {{ ref('int_customer__names') }} as int_customer__names
        left join {{ ref('int_customer__creditcard') }} as int_customer__creditcard
            on int_customer__creditcard.businessentityid = int_customer__names.customerid
    )
select *
from final
