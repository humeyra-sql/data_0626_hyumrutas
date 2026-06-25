with sales_margin as (
    select
        orders_id,
        date_date,
        margin
    from {{ ref('int_sales_margin') }}
),

ship as (
    select
        orders_id,
        shipping_fee  as nakliye_ucreti,
        ship_cost     as gemi_maliyeti
    from {{ source('raw','ship') }}
),

log as (
    select
        orders_id,
        logcost as log_maliyeti
    from {{ source('raw','ship') }}
)

select
    s.orders_id,
    s.date_date,
    s.margin,
    sh.nakliye_ucreti,
    lg.log_maliyeti,
    sh.gemi_maliyeti,
    (s.margin
      + coalesce(cast(sh.nakliye_ucreti as numeric), 0)
      - coalesce(cast(lg.log_maliyeti as numeric), 0)
      - coalesce(cast(sh.gemi_maliyeti as numeric), 0)
    ) as operasyonel_margin
from sales_margin as s
left join ship as sh on s.orders_id = sh.orders_id
left join log as lg on s.orders_id = lg.orders_id