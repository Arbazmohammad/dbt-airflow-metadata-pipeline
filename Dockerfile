FROM astrocrpublic.azurecr.io/runtime:3.1-11

# Install git (required by dbt) and ensure dbt packages are available
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv /dbt_venv && . /dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-core==1.9.4 dbt-snowflake==1.9.4 && deactivate
