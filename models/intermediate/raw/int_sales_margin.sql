with sales as (
    select
        orders_id,
        products_id,
        quantity, 
        revenue
    from {{ source('raw','sales') }}
),
products as (
    select
        products_id,
        purchase_price as satin_alma_fiyati
    from {{ source('raw','products') }}
)

select
    s.orders_id,
    s.products_id,
    s.quantity,
    s.revenue,
    p.satin_alma_fiyati,
    s.quantity * p.satin_alma_fiyati as satin_alma_maliyeti,
    s.revenue - (s.quantity * p.satin_alma_fiyati) as marj
from sales as  s
left join products as p
    on s.products_id = p.products_id