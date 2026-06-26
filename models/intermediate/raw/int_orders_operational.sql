with sales_margin as (
    select
        orders_id,
        date_date,
        revenue,
        quantity,
        purchase_cost,
        margin
    from {{ ref('int_sales_margin') }}
),

ship as (
    select
        orders_id,
        shipping_fee,
        ship_cost,
        logcost
    from {{ source('raw','ship') }}
)

select
    s.orders_id,
    s.date_date,
    s.revenue,
    s.quantity,
    s.purchase_cost,
    s.margin,
    sh.shipping_fee,
    sh.ship_cost,
    sh.logcost,
    (
        s.margin
        + coalesce(cast(sh.shipping_fee as numeric), 0)
        - coalesce(cast(sh.logcost as numeric), 0)
        - coalesce(cast(sh.ship_cost as numeric), 0)
    ) as operational_margin
from sales_margin as s
left join ship  as sh
    on s.orders_id = sh.orders_id