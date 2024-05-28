{{config(materialized='table')}}

with dim_order_dates as (
	select
		row_number() over(order by order_date asc) as orderdate_sk_id,
		order_date as order_time_stamp,
		date(order_date) as date,
		extract(year from order_date) as year,
		extract(month from order_date) as month,
		(case
			when extract(month from order_date) = 1 then 'January'
			when extract(month from order_date) = 2 then 'February'
			when extract(month from order_date) = 3 then 'March'
			when extract(month from order_date) = 4 then 'April'
			when extract(month from order_date) = 5 then 'May'
			when extract(month from order_date) = 6 then 'June'
			when extract(month from order_date) = 7 then 'July'
			when extract(month from order_date) = 8 then 'August'
			when extract(month from order_date) = 9 then 'September'
			when extract(month from order_date) = 10 then 'October'
			when extract(month from order_date) = 11 then 'November'
			when extract(month from order_date) = 12 then 'December'
		end)::varchar as month_name,
		extract(day from order_date) as day,
		extract(dow from order_date) as dow,
		extract(hour from order_date) as hour,
		extract(minute from order_date) as minute,
		(case
			when extract(dow from order_date) = 0 then 'Sunday'
			when extract(dow from order_date) = 1 then 'Monday'
			when extract(dow from order_date) = 2 then 'Tuesday'
			when extract(dow from order_date) = 3 then 'Wednesday'
			when extract(dow from order_date) = 4 then 'Thursday'
			when extract(dow from order_date) = 5 then 'Friday'
			when extract(dow from order_date) = 6 then 'Saturday'
		end)::varchar as day_of_week
	from (select
		distinct order_date
	from {{ref('stg_fact_sales')}}) distinct_order_date
)

select *
from dim_order_dates
