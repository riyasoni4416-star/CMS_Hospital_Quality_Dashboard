# CMS_Hospital_Quality_Dashboard, ED Throughput and Readmission Dashboard
This project analyzes CMS hospital quality data using PostgreSQL and Power BI.

## Tools
- PostgreSQL
- pgAdmin
- Power BI

## Project Goal
To evaluate hospital performance across emergency department related measures, readmission metrics, and data completeness indicators.

## Workflow
1. Imported raw CMS CSV files into PostgreSQL
2. Created raw, stage, and mart layers
3. Cleaned text, date, and numeric reporting fields
4. Built hospital and state level summary views
5. Developed an interactive Power BI dashboard

## Dashboard Pages
- Executive Overview
- ED Throughput Benchmarking
- Readmission and Return Visit Benchmarking
- Data Quality Overview

## Key Skills Demonstrated
- SQL data cleaning
- joins and aggregations
- view creation
- healthcare KPI reporting
- Power BI modeling and dashboarding

## Example Insights
- Some states had weaker ED related performance despite similar hospital counts.
- Certain hospital categories showed more measures worse than national.
- Missingness in reporting fields varied across hospitals.

## Files
- `sql/` contains PostgreSQL scripts
- `screenshots/` contains dashboard images
