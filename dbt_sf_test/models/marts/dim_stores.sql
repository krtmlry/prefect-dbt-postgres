
{{config(materialized='table')}}


with dim_stores as (
	select
	row_number() over() as store_id,
	store
	from (
		select distinct store
		from {{ref('stg_fact_sales')}}
		order by store asc
	) distinct_stores
)

select *
from dim_stores