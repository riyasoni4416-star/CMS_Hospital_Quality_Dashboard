# CMS Hospital Quality, ED Throughput, and Readmission Dashboard

This project analyzes public CMS hospital quality data using PostgreSQL and Power BI. The goal was to build a healthcare analytics workflow that cleans raw hospital reporting files, creates structured reporting views, and visualizes hospital performance across emergency department related measures, readmission metrics, and data completeness indicators.

## Project Goal

To evaluate how hospitals compare on quality and operational performance measures, with a focus on emergency department related metrics, readmission related outcomes, and completeness of reported data.

## Tools Used

- PostgreSQL
- pgAdmin
- Power BI

## Data Source

This project uses publicly available CMS hospital datasets:

- Hospital General Information
- Timely and Effective Care, Hospital
- Unplanned Hospital Visits, Hospital

## Workflow

The project was built in three SQL layers:

### Raw layer
Imported CMS CSV files into PostgreSQL raw tables.

### Stage layer
Cleaned and standardized fields by:
- trimming extra spaces
- converting blank strings to null
- converting numeric values stored as text into numeric format
- converting date fields into proper date format
- handling text values such as `Not Available` and `Number of Cases Too Small`

### Mart layer
Built reporting ready views for analysis and dashboarding:
- hospital_dimension
- ed_throughput_measures
- readmission_measures
- hospital_quality_overview
- state_summary
- data_quality_summary

## Dashboard Pages

### 1. Executive Overview
High level summary of hospitals, overall ratings, and benchmarking metrics by state and ownership.

### 2. ED Throughput Benchmarking
Comparison of hospital performance across emergency department related process measures.

### 3. Readmission and Return Visit Benchmarking
Comparison of hospital level readmission and unplanned visit metrics against national benchmarks.

### 4. Data Quality Overview
Assessment of missingness in hospital ratings and measure reporting fields.

## Key Skills Demonstrated

- SQL data cleaning and transformation
- view creation using raw, stage, and mart layers
- joins and aggregations
- healthcare KPI reporting
- Power BI data modeling
- interactive dashboard design
- data quality assessment

## Example Insights

- Some states showed lower average ED related performance despite similar hospital counts.
- Certain hospital categories had more measures classified as worse than national.
- Missingness in key reporting fields varied across facilities, which could affect benchmarking interpretation.

## Project Structure

```text
CMS_Hospital_Quality_Dashboard/
│
├── sql/
│   ├── 01_raw_tables.sql
│   ├── 02_stage_and_mart_views.sql
│   └── 03_validation_queries.sql
│
├── screenshots/
│   ├── page1_overview.png
│   ├── page2_ed_benchmarking.png
│   ├── page3_readmissions.png
│   └── page4_data_quality.png
│
└── README.md