select
  f.date_date,

  -- finance_days
  f.avg_basket as average_basket,
  f.operational_margin,
  f.total_quantity_sold as quantity,
  f.total_revenue as revenue,
  f.total_purchase_cost as purchase_cost,
  (f.total_revenue - f.total_purchase_cost) as margin,   
  f.total_shipping_fees as shipping_fee,
  f.total_logistics_cost as log_cost,

  -- ads (int_campaigns_day’dan)
  coalesce(c.ads_cost, 0) as ads_cost,
  coalesce(c.impression, 0) as ads_impression,
  coalesce(c.click, 0) as ads_clicks,

  -- hesap
  f.operational_margin - coalesce(c.ads_cost, 0) as ads_margin

from {{ ref('finance_days') }} f
left join {{ ref('int_campaigns_day') }} c
  on f.date_date = c.date_date
order by f.date_date desc