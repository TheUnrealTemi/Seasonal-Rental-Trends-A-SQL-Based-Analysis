#WGU - D326: Advanced Data Management Final Project

This task defines a report as a collection of data that answers a real-world business question. Your report will have two distinct sections (SQL tables that you will create) that differ in the granularity of the data they present and how directly they support the answering of the business question you choose. The detailed table should contain all data that informs the answer to the question at a very granular level, and the summary table should contain aggregated data that provide a direct answer to the business question.

A.  Summarize one real-world written business report that can be created from the DVD Dataset from the “Labs on Demand Assessment Environment and DVD Database” attachment. 
1.  Identify the specific fields that will be included in the detailed table and the summary table of the report.
2.  Describe the types of data fields used for the report.
3.  Identify at least two specific tables from the given dataset that will provide the data necessary for the detailed table section and the summary table section of the report.
4.  Identify at least one field in the detailed table section that will require a custom transformation with a user-defined function and explain why it should be transformed (e.g., you might translate a field with a value of N to No and Y to Yes).
5.  Explain the different business uses of the detailed table section and the summary table section of the report. 
6.  Explain how frequently your report should be refreshed to remain relevant to stakeholders.
 
B.  Provide original code for function(s) in text format that perform the transformation(s) you identified in part A4.
 
C.  Provide original SQL code in a text format that creates the detailed and summary tables to hold your report table sections.
 
D.  Provide an original SQL query in a text format that will extract the raw data needed for the detailed section of your report from the source database.
 
E.  Provide original SQL code in a text format that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.
 
F.  Provide an original stored procedure in a text format that can be used to refresh the data in both the detailed table and summary table. The procedure should clear the contents of the detailed table and summary table and perform the raw data extraction from part D.
1.  Identify a relevant job scheduling tool that can be used to automate the stored procedure.

# Seasonal-Rental-Trends-A-SQL-Based-Analysis
Developed a Customer Rental Pattern report by transforming raw rental data into seasonal insights using SQL, optimizing trend analysis and identifying peak rental periods, which enabled strategic decision-making on inventory investments.

The real-world business report that I will be creating with the database is the Customer Rental Pattern. I will be analyzing the data, to identify peak rental periods and preferred category. The Key Metrics I will be looking at is rental date categorized into seasons, rental count per season, and the most rented category in a season.

1.	Detail table fields: rental_season, category_name, and count_rental_id
    Summary table fields: rental_season, and count_rental_id
2.	Data types are Integer, and Varchar
3.	The tables that will help provide the data necessary are the category, film_category, inventory and rental tables
4.	I will be transforming the rental_date field from the rental table to create a new field called rental_season in the detailed table. This transformation is necessary because the raw rental_date is too granular for seasonal analysis. By categorizing the rental dates into seasons (Spring, Summer, Fall, Winter), I can provide insights on peak rental periods in a more meaningful way, allowing for trend analysis by season rather than individual dates.
5.	The summery table will be used to get high level insight into seasonal rental performance, to help identify the time periods we see the most volume. While the detailed table will give us more information on how a category performs in a particular season, so we can better strategize on the types of category we need to invest more into, and in what season.
6.	I believe the report should be refreshed monthly, since it is used for identifying seasonal trends.