with final as (
    select
        productid
        , product
from {{ ref('stg_product__product') }}
)
select * 
FROM final

