select 
  date_date,
  orders_id,
  revenue,
  from{{source('raw','sales')}}