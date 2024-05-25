{{ config(materialized='materialized_view')}}


with stg_fact_sales as (

	select
		row_number() over() as order_sk_id,
		*
	from {{ref('stg_product_sales')}}
)

select *
from stg_fact_sales