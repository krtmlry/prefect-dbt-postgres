{{ config(materialized='table')}}

with dim_customers as (
	select
		row_number() over (order by order_date asc) customer_sk_id,
		purchase_address,
		ltrim(split_part(purchase_address,',',2))::varchar as city
	from ( select distinct purchase_address, order_date
	from {{ref('stg_fact_sales')}} ) distinct_address
)

select *
from dim_customers