"""
DBT Airflow DAG for Airbnb Snowflake Project

This DAG orchestrates the execution of dbt models with the following layers:
- Bronze: Raw data ingestion
- Silver: Data cleaning and transformation
- Gold: Business-ready fact and dimension tables
"""

import os
from datetime import datetime, timedelta
from pathlib import Path
from cosmos import DbtDag, ProfileConfig, ProjectConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

# Configuration
DBT_PROJECT_PATH = Path("/usr/local/airflow/dags/dbt/aws_dbt_snowflake_project")
DBT_EXECUTABLE = "dbt"
SNOWFLAKE_CONN_ID = "snowflake_conn"
SNOWFLAKE_DATABASE = "AIRBNB"
SNOWFLAKE_SCHEMA = "dbt_schema"
PROFILE_NAME = "default"
TARGET_NAME = "dev"

# Profile configuration for Snowflake connection
profile_config = ProfileConfig(
    profile_name=PROFILE_NAME,
    target_name=TARGET_NAME,
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id=SNOWFLAKE_CONN_ID,
        profile_args={
            "database": SNOWFLAKE_DATABASE,
            "schema": SNOWFLAKE_SCHEMA,
        },
    ),
)

# Project configuration
project_config = ProjectConfig(
    dbt_project_path=str(DBT_PROJECT_PATH),
    manifest_path=str(DBT_PROJECT_PATH / "target" / "manifest.json"),
)

# Execution configuration
execution_config = ExecutionConfig(
    dbt_executable_path=DBT_EXECUTABLE,
    invocation_mode="subprocess",
)

# DAG definition with improved configuration
dbt_snowflake_dag = DbtDag(
    dag_id="dbt_airbnb_snowflake_pipeline",
    project_config=project_config,
    profile_config=profile_config,
    execution_config=execution_config,
    operator_args={
        "install_deps": True,
        "dbt_cmd_flags": "--debug",
    },
    schedule_interval="0 2 * * *",  # Run daily at 2 AM UTC
    start_date=datetime(2026, 1, 31),
    end_date=None,
    catchup=False,
    max_active_runs=1,
    tags=["dbt", "snowflake", "airbnb"],
    description="DBT pipeline for Airbnb Snowflake data warehouse",
    owner="data-engineering",
    email_on_failure=False,
    default_view="tree",
)