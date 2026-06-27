with sales as (
    select
        date_date,
        orders_id,
        pdt_id as products_id,
        revenue,
        quantity
    from {{ source('raw','sales') }}
),
products as (
    select
    products_id,
    safe_cast(purchse_price as float64) as purchase_price
    from {{ source('raw','products') }}
)

select
    s.orders_id,
    s.date_date,
    s.revenue,
    s.quantity,
    s.quantity * p.purchase_price as purchase_cost,
    round(s.revenue - (s.quantity * p.purchase_price),2) as margin
from sales as  s
left join products as p
    on s.products_id = p.products_id