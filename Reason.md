# Reason for updating the project.

The previous [project](https://github.com/krtmlry/product_sales_2019) was my first time creating an etl pipeline and I was only following from a youtube video and I realized that it had some mistakes(based on my assumption).

The mistake was on the data modelling part where after all the data cleaning was done.

I divided the table into fact and dim tables where I added surrogate keys to each tables.

After surrogate keys were added I then performed joins to create a fact table.

But after some time I realized that all of my dim tables have the same number of rows with my fact table which was a mistake on my part.

Best example would be the images below: