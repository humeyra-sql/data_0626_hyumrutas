select
  Parcel_id as parcel_id,
  Parcel_tracking as parcel_tracking,
  Transporter as transporter,
  Priority as priority,
  parse_date("%B %e, %Y", Date_purCHase) as date_purchase,
  parse_date("%B %e, %Y", Date_sHIpping) as date_shipping,
  parse_date("%B %e, %Y", DATE_delivery) as date_delivery,
  parse_date("%B %e, %Y", DaTeCANcelled) as date_cancelled
from {{ source('raw_data_circle','raw_cc_parcel') }}