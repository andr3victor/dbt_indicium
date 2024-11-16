with 
    personcreditcard_tb as (
       select
        creditcard.creditcardid
        ,personcreditcard.businessentityid
        ,creditcard.cardtype 
       from {{ ref('stg_customer__creditcard') }} as creditcard
       left join {{ ref('stg_customer__personcreditcard') }} as personcreditcard 
        on creditcard.creditcardid = personcreditcard.creditcardid
    )
select *
from personcreditcard_tb
where creditcardid is not null