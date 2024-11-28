# DBT Project: Brand Awareness Reporting

## Project Overview

This DBT project is designed to transform survey data into actionable insights by calculating brand awareness metrics, such as awareness percentages and 3-month rolling averages. The data is structured using a star schema, optimized for performance and reporting with tools like Tableau, Power BI, and other reporting tools.

## Getting Started

### Prerequisites

- **DBT Core** version 1.8.5
- **PostgreSQL** database (aws hosted)
### Database Access

The PostgreSQL database for this project is hosted and can be accessed with the following credentials:

- **Host**: `database-1.cji48ooyyih5.us-east-1.rds.amazonaws.com `
- **Port**: `5432`
- **Database Name**: `postgres`
- **Username**: `postgres`
- **Password**: Please contact the database administrator to obtain the password.

### Setup Instructions

1. **Configure DBT**:
   - Update `profiles.yml` with the provided database credentials:
     ```yaml
     tracksuit_data_technical_test:
       target: dev
       outputs:
         dev:
           type: postgres
           host: your-database-host.rds.amazonaws.com
           user: your-username
           password: "{{ env_var('DB_PASSWORD') }}" 
           port: 5432
           dbname: your-dbname
           schema: datamartsq
           threads: 4
     ```

## Project Structure

- **models/**: Contains DBT models organized into `staging`, `intermediate`, and `marts` layers.
- **seeds/**: Raw data files in CSV and JSON formats.
- **snapshots/**: Captures and maintains historical data.
- **tests/**: DBT tests to validate data integrity.
- **macros/**: Reusable SQL snippets and functions.

## Data Modeling

The data is organized into the following key tables:

- **Dimensions**:
  - `dim_brand_snapshot`: Tracks changes in brand data.
  - `dim_date`: Date-related attributes for analysis.
  - `dim_respondent`: Survey respondent information.
  - `dim_category`: Category information.
  - `dim_question`: Survey question details.

- **Facts**:
  - `fact_brand`: Brand-related facts.
  - `summary_fact_brand`: Aggregated brand metrics, including awareness percentages and rolling averages.

- **Additional datasets**
  - Additional datasets were included as part of the enhancements and integrated into the marts model. However, the reporting model focuses on addressing the primary questions.
  - raw_brand_infomration.csv
  - raw_respondent_demographics.csv

## Data Visualization

A Streamlit application is provided for interactive data exploration, including:

- Slider bars for filtering by date range.
- Visualizations of awareness percentages and rolling averages.

Refer to the streamlit application link: [Streamlit] (http://98.82.5.19/)

**Please Note:** The application is hosted on an EC2 instance and is accessible. If you encounter any issues accessing the Streamlit application, feel free to reach out.
## DBT Documentation

For detailed information on the DBT models, transformations, and testing strategies, refer to the [DBT Documentation](http://dbt-docs-tracksuit-data.s3-website-us-east-1.amazonaws.com/#!/overview). This documentation includes:

- Comprehensive model descriptions.
- Data transformation logic.
- Testing methodologies.
- Data lineage and dependencies.