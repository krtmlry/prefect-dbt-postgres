# prefect-dbt-elt-pipeline

### About
This is an update of my previous [project](https://github.com/krtmlry/product_sales_2019) which was an ETL process using Python for the entire ETL process. I altered the dataset used and added two additional columns for data modelling practice.
Reasons for updating this project can be read [here](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/Reason.md).

### Files
`dbt_sf_test` - contains dbt related files

`prefect_flows` - contains the python script that
orchestrated the entire process

`Dataset` can be seen [here](https://github.com/krtmlry/datasets/tree/main/merged_sales_csv)

### Data model diagram

![image](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/img/datamodeldiagram_new.png)


### Project architecture

![image](https://github.com/krtmlry/prefect-dbt-postgres/blob/main/img/project%20diagram.png)

The data will be extracted from a local csv file and will be loaded into a staging table.
After data is loaded the dbt models will be triggered to transform the data accordingly.