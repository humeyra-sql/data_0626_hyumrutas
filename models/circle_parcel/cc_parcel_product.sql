select
 pr.parcel_id,
 pr.model_name,
 pr.qty
 from {{ref('stg_cc_parcel_product')}} pr
 join {{ref('cc_parcel')}} p
 using (parcel_id)
