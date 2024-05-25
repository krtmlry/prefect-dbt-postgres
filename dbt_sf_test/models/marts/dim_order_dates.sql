{{config(materialized='table')}}

with dim_order_dates as (
	select
		row_number() over() as orderdate_sk_id,
		order_date as order_time_stamp,
		date(order_date) as date,
		extract(year from order_date) as year,
		extract(month from order_date) as month,
		extract(day from order_date) as day,
		extract(dow from order_date) as dow,
		extract(hour from order_date) as hour,
		extract(minute from order_date) as minute,
		(CASE
			WHEN extract(dow from order_date) = 0 THEN 'Sunday'
			WHEN extract(dow from order_date) = 1 THEN 'Monday'
			WHEN extract(dow from order_date) = 2 THEN 'Tuesday'
			WHEN extract(dow from order_date) = 3 THEN 'Wednesday'
			WHEN extract(dow from order_date) = 4 THEN 'Thursday'
			WHEN extract(dow from order_date) = 5 THEN 'Friday'
			WHEN extract(dow from order_date) = 6 THEN 'Saturday'
		END)::varchar as day_of_week
	from (select
		distinct order_date
	from {{ref('stg_fact_sales')}}) distinct_order_date
)

select *
from dim_order_dates
