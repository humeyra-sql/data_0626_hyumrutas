{{ config(materialized='table') }}
with orders as (

    -- 1 satır = 1 sipariş 
    select
        date_date,     
        orders_id,
        revenue,                              -- sipariş geliri
        purchase_cost,                        -- satın alma maliyeti (COGS gibi)
        shipping_fee,                            -- nakliye ücreti (müşteriden alınan veya ödenen senaryona göre)
        logcost,                              -- lojistik maliyet
        quantity                              -- siparişte satılan toplam ürün adedi

    from {{ ref('int_orders_operational') }}              -- örn: int_orders / stg_orders vs.
),

finance_days as (

    select
        date_date,
        count(distinct orders_id) as total_transactions,
        round(sum(revenue),2) as total_revenue,

        -- Ortalama sepet = gelir / işlem sayısı
        -- divide by zero koruması:
        round(sum(revenue) / nullif(count(distinct orders_id), 0),2) as avg_basket,

        round(sum(purchase_cost),2) as total_purchase_cost,
        round(sum(shipping_fee),2) as total_shipping_fees,
        round(sum(logcost),2) as total_logistics_cost,

        -- Operasyonel marjı netleştirmek gerekebilir.
        -- Yaygın tanım: revenue - purchase_cost - shipping_fee - logistics_cost
        round(( sum(revenue)
          - sum(purchase_cost)
          - sum(shipping_fee)
          - sum(logcost)
        ),2) as operational_margin,

        round(sum(quantity),2) as total_quantity_sold

    from orders
    group by date_date
)

select *
from finance_days
order by date_date