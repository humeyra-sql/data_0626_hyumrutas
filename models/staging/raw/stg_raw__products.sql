with 

source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        products_id,
        cast(float64(purchse_price )) as purchase_price

    from source

)

select * from renamed