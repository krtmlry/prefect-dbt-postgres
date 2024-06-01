-- to remove nulls and repeating headers

{{ config(materialized='view') }}

with t_rm_nulls_dups as (
	select distinct *
	from raw_sales_landing
	where "Order ID" != 'Order ID' and "Order ID" is not null
)

select *
from t_rm_nulls_dups