import pandas as pd
from sqlalchemy import create_engine
from prefect import task, flow
import psycopg2
import os
from dotenv import load_dotenv
from dbt.cli.main import dbtRunner, dbtRunnerResult

load_dotenv()

@task(name='extract-data')
def get_csv():
    merged_csv_path = os.getenv('merged_csv_path')
    df = pd.read_csv(merged_csv_path)
    return df

@task(name='load-data-to-db')
def load_data(df):
    db_user = os.getenv('db_user')
    db_name = os.getenv('db_sf_test')
    db_pass = os.getenv('db_pass')
    db_host = os.getenv('db_host')
    db_port = os.getenv('db_port')
    engine = create_engine(f'postgresql+psycopg2://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}')
    df.to_sql('raw_sales_landing',engine, if_exists='append', index=False)
    

@task(name='dbt-runs')
def dbt_runs():
    dbt_sf_test_dir = os.getenv('dbt_sf_test_dir')
    dbt_profiles_dir = os.getenv('dbt_profiles')
    dbt = dbtRunner()

    cli_args_1 = ["run", "-m", "tag:p1", "--project-dir", dbt_sf_test_dir, "--profiles-dir", dbt_profiles_dir]
    cli_args_2 = ["run", "-m", "tag:p2", "--project-dir", dbt_sf_test_dir, "--profiles-dir", dbt_profiles_dir]

    res_1 = dbt.invoke(cli_args_1)
    res_2 = dbt.invoke(cli_args_2)

    for r in res_1.result:
        print(f"{r.node.name}: {r.status}")
        
    for r in res_2.result:
        print(f"{r.node.name}: {r.status}") 
    
@flow()
def main():
    df = get_csv()
    load_data(df)
    dbt_runs()
    
if __name__ == '__main__':
    main()