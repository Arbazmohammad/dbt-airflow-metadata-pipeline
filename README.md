# dbt-airflow-metadata-pipeline

## Overview

This project implements a metadata pipeline for Airbnb booking data using the **medallion architecture** (Bronze, Silver, Gold layers). It extracts raw data from an AWS S3 bucket, loads it into Snowflake staging tables, transforms it using DBT, and orchestrates the workflow with Airflow.

## Architecture
<img width="1680" height="820" alt="image" src="https://github.com/user-attachments/assets/a3cf4bc3-2110-400a-a908-08bbe1c7a2ac" />


- **Bronze Layer:** Raw data ingested from S3 into Snowflake using the `COPY` command.
- **Silver Layer:** Cleansed and enriched data models built with DBT.
- **Gold Layer:** Business-ready tables, including a consolidated "One Big Table" (OBT) for analytics.
- **Airflow DAG:** Automates the end-to-end pipeline, from extraction to transformation.

## Tech Stack
<img width="1493" height="527" alt="Screenshot 2026-02-05 at 9 23 58 PM" src="https://github.com/user-attachments/assets/76983537-dc63-488d-a401-b0fe5d1a8138" />


## Pipeline Steps

1. **Extract:** Pull Airbnb booking data from AWS S3.
2. **Load:** Stage data in Snowflake (Bronze).
3. **Transform:** Use DBT to build Silver and Gold models.
4. **Aggregate:** Create the OBT for unified analytics.
5. **Orchestrate:** Manage the workflow with Airflow.

## Key Features

- Medallion architecture for scalable data modeling
- Automated data extraction and loading
- Modular DBT transformations
- Airflow orchestration for reliability and scheduling

## Project Structure

```
aws_dbt_snowflake_project/
├── models/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│   │   └── obt.sql
│   │   └── fact.sql        
├── dags/
│   └── dbt_dag.py
├── dbt_project.yml
└── README.md
```


## Project Pipeline
<img width="1908" height="925" alt="image" src="https://github.com/user-attachments/assets/74e2e2d5-0356-494e-ad94-1b1a4c7a05f0" />


## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Arbazmohammad/dbt-airflow-metadata-pipeline.git
   ```
2. Set up your AWS, Snowflake, and DBT credentials.
3. Run the Airflow DAG to orchestrate the pipeline.
4. Prerequisite: Docker, Astro CLI, Snowflake account



##


**Built by [Arbaz Mohammad](https://github.com/Arbazmohammad)**
