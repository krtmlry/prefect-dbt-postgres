{{config(materialized='view')}}

with cast_types as (
	select
		cast("Order ID" as int) as order_id,
		cast("Product" as varchar) as product,
		cast("Price Each" as numeric(10,2)) as price_each,
		cast("Quantity Ordered" as int) as qty_ordered,
		cast("Order Date" as timestamp) as order_date,
		cast("Purchase Address" as varchar) as purchase_address,
		cast("Store" as varchar) as store,
		cast("Payment Method" as varchar) as payment_method
	from {{ref('t_rm_nulls_dups')}}
)
select *
from cast_types