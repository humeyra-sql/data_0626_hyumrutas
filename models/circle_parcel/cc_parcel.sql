with product_parcel as(
select 
 parcel_id,
 sum(qty) as qty,
 count(distinct model_name) as nb_product
from {{ref('stg_cc_parcel_product')}}
group by parcel_id
)
select
 p.parcel_id,
 p.parcel_tracking,
 p.transporter,
 p.priority,
 p.date_purchase,
 p.date_shipping,
 p.date_delivery,
 p.date_cancelled,
 extract (month from p.date_purchase) as month_purchase,
 case
    when p.date_cancelled is not null then 'İptal Edildi'
    when p.date_shipping is null then 'Devam Ediyor'
    when p.date_delivery is null then 'Taşınıyor'
    when p.date_delivery is not null then 'Teslim Edildi'
    else null
  end as status,
  date_diff(p.date_shipping,p.date_purchase, day) as expedition_time,
  date_diff(p.date_delivery,p.date_shipping, day) as transport_time,
  date_diff(p.date_delivery,p.date_purchase, day) as deliery_time,

case
  when p.date_delivery is null then null
  when date_diff(p.date_delivery, p.date_purchase, day) > 5 then 1
  else 0
end as delay,

  n.qty,
  n.nb_product
  from {{ref('stg_cc_parcel')}} p 
  left join product_parcel n 
  using (parcel_id)