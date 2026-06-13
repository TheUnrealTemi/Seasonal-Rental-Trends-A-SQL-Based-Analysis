# Seasonal Rental Trends: A SQL-Based Analysis

## Overview

Seasonal Rental Trends is a SQL-based business intelligence project that analyzes customer rental behavior using the DVD Rental database. The solution transforms raw transactional data into seasonal insights, enabling stakeholders to identify peak rental periods and understand category-level demand throughout the year.

The project implements a complete reporting workflow that includes data transformation, aggregation, automated report generation, database triggers, and stored procedures.

---

## Business Problem

A DVD rental business needs visibility into seasonal customer demand patterns to make informed inventory and marketing decisions.

Analyzing individual rental transactions provides limited strategic value. By transforming rental dates into seasonal categories and aggregating rental activity by film category, stakeholders can identify:

* Peak rental seasons
* High-performing content categories
* Seasonal shifts in customer preferences
* Inventory investment opportunities

---

## Solution

This project converts raw rental transaction data into two reporting layers:

### Detailed Report

Provides category-level rental performance by season.

### Summary Report

Provides high-level seasonal rental trends and total rental volume.

Together, these reports support both operational and strategic decision-making.

---

## Key Features

* Transform rental dates into seasonal classifications
* Aggregate rental activity by season and category
* Generate detailed and summary reporting tables
* Automate report updates using database triggers
* Refresh report data using stored procedures
* Support scheduled monthly reporting
* Enable seasonal trend analysis and forecasting

---

## Technologies Used

* PostgreSQL
* SQL
* PL/pgSQL
* User-Defined Functions
* Triggers
* Stored Procedures
* Data Aggregation
* ETL Processes
* Relational Database Design

---

## Database Tables

### Source Tables

| Table         | Purpose                          |
| ------------- | -------------------------------- |
| rental        | Customer rental transactions     |
| inventory     | Maps rentals to inventory items  |
| film_category | Associates films with categories |
| category      | Stores category information      |

### Reporting Tables

| Table                  | Purpose                                 |
| ---------------------- | --------------------------------------- |
| detailed_rental_report | Seasonal rental performance by category |
| summary_rental_report  | High-level rental performance by season |

---

## Data Transformation

The rental_date field is transformed into a new business-friendly attribute called rental_season.

### Seasonal Mapping

| Month                | Season |
| -------------------- | ------ |
| December – February  | Winter |
| March – May          | Spring |
| June – August        | Summer |
| September – November | Fall   |

This transformation allows stakeholders to analyze long-term rental patterns at a seasonal level rather than at the individual transaction level.

Example SQL logic:

```sql
CASE
    WHEN EXTRACT(MONTH FROM rental_date) IN (12,1,2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM rental_date) IN (3,4,5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM rental_date) IN (6,7,8) THEN 'Summer'
    WHEN EXTRACT(MONTH FROM rental_date) IN (9,10,11) THEN 'Fall'
END
```

---

## Report Architecture

### Detailed Report

The detailed report provides category-level rental performance.

| rental_season | category_name | total_rental |
| ------------- | ------------- | ------------ |
| Summer        | Action        | 520          |
| Summer        | Comedy        | 487          |
| Winter        | Family        | 615          |

Business Use:

* Identify top-performing categories
* Understand seasonal customer preferences
* Support inventory purchasing decisions

---

### Summary Report

The summary report aggregates rental activity by season.

| rental_season | total_rental |
| ------------- | ------------ |
| Winter        | 5102         |
| Summer        | 4832         |
| Fall          | 3761         |
| Spring        | 3125         |

Business Use:

* Identify peak rental seasons
* Support forecasting and planning
* Measure overall seasonal demand

---

## Automated Reporting Workflow

```text
Rental Data
     │
     ▼
Season Classification
     │
     ▼
Detailed Rental Report
     │
     ▼
Database Trigger
     │
     ▼
Summary Rental Report
```

### Step 1

Rental records are extracted and transformed into seasonal classifications.

### Step 2

Rental activity is aggregated by category and season.

### Step 3

Data is inserted into the detailed reporting table.

### Step 4

A database trigger automatically rebuilds the summary report whenever new data is inserted into the detailed report.

---

## Trigger Implementation

A PostgreSQL trigger automatically updates the summary report table whenever the detailed report receives new data.

Responsibilities:

* Clear existing summary data
* Recalculate seasonal totals
* Repopulate summary report

This ensures that summary metrics remain synchronized with detailed reporting data.

---

## Stored Procedure

The project includes a stored procedure that refreshes reporting data by:

1. Clearing existing report data
2. Re-extracting source data
3. Rebuilding the detailed report
4. Automatically updating the summary report through the trigger

Benefits:

* Eliminates manual report maintenance
* Ensures data consistency
* Supports recurring business reporting

---

## Report Automation

Recommended Refresh Frequency: Monthly

Scheduling Tool:

* pgAgent

Automating the refresh process ensures stakeholders always have access to current seasonal performance metrics.

---

## Skills Demonstrated

### SQL Development

* Complex joins
* Aggregations
* Grouping and filtering
* Data transformation

### Database Engineering

* Trigger development
* Stored procedures
* Report automation
* ETL workflows

### Data Analytics

* Trend analysis
* Seasonal segmentation
* Business reporting
* KPI development

### Business Intelligence

* Translating business questions into data solutions
* Designing detailed and summary reporting layers
* Supporting strategic decision-making through analytics

---

## Key Outcomes

* Converted raw rental transactions into actionable business insights
* Automated report generation using PostgreSQL triggers and procedures
* Enabled identification of peak rental periods and category demand
* Created a scalable reporting solution that supports recurring business analysis

---

## Author

Temitope Otunbanjo

Bachelor of Science, Computer Science
Western Governors University
