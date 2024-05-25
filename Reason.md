# Reason for updating the project.

The previous [project](https://github.com/krtmlry/product_sales_2019) was my first time creating an etl pipeline and I was only following from a youtube video and I realized that it had some mistakes(based on my assumption).

The mistake was on the data modelling part where after all the data cleaning was done.

I divided the table into fact and dim tables where I added surrogate keys to each tables.

After surrogate keys were added I then performed joins to create a fact table.

But after some time I realized that all of my dim tables have the same number of rows with my fact table which was a mistake on my part.

Best example would be the images below:

![dim_customers](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/img/customer_dim.png)
![dim_products](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/img/dim_products.png)
![order_details](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/img/order_details.png)

Both dimension tables have the same number of rows with the order details table and this was something that I didn't understand when I first started this project.