{{ config(
  alias='cc_parcel_products',
  materialized='table',
  partition_by={"field": "date_purchase", "data_type": "date", "granularity": "day"}
) }}

select
  pr.parcel_id,
  pr.model_name,
  pr.qty,
  p.date_purchase,
  p.date_shipping,
  p.date_delivery,
  p.date_cancelled
from {{ ref('stg_cc_parcel_products') }} pr
join {{ ref('cc_parcel') }} p
using (parcel_id)