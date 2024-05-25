{{config(materialized='table')}}

with dim_products as (
	select 
		row_number() over() as product_id,
		product,
		price_each
	from (select distinct product, price_each
	from  {{ref('stg_fact_sales')}}
	order by product asc) distinct_product
)
select *
from dim_products