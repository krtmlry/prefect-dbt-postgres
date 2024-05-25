{{config(materialized='view')}}

with stg_product_sales as (
	select
		order_id,
		product,
		price_each,
		qty_ordered,
		(price_each * qty_ordered)::numeric as total_price,
		order_date,
		purchase_address,
		store,
		payment_method
	from {{ ref('t_cast_types') }}
	where extract(year from order_date) = 2019
	order by 
	extract(month from order_date) asc,
	extract(day from order_date) asc,
	extract(hour from order_date) asc,
	extract(minute from order_date) asc,
	extract(second from order_date) asc
)

select *
from stg_product_sales