SELECT 
  concat(cast(date_date as string), '-', 'adwords', '-', cast(campaign_key as string)) as campaign_id,
  date_date,
  paid_source,
  campaign_key,
  campaign_name,
  ads_cost,
  impression,
  click
from {{ ref('stg_raw_adwords') }}

UNION ALL 

SELECT 
  concat(cast(date_date as string), '-', 'bing', '-', cast(campaign_key as string)) as campaign_id,
  date_date,
  paid_source,
  campaign_key,
  campaign_name,
  ads_cost,
  impression,
  click
FROM {{ref("stg_raw_bing")}}

UNION ALL 

SELECT 
  concat(cast(date_date as string), '-', 'criteo', '-', cast(campaign_key as string)) as campaign_id,
  date_date,
  paid_source,
  campaign_key,
  campaign_name,
  ads_cost,
  impression,
  click
FROM {{ref("stg_raw_criteo")}}

UNION ALL 

SELECT 
  concat(cast(date_date as string), '-', 'facebook', '-', cast(campaign_key as string)) as campaign_id,
  date_date,
  paid_source,
  campaign_key,
  campaign_name,
  ads_cost,
  impression,
  click
 FROM {{ref("stg_raw_facebook")}}
