with 

source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        products_id,
        cast(purchse_price as FLOAT64) as purchase_price

    from source

)

select * from renamed