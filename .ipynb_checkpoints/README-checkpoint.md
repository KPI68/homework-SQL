# homework-SQL

## Summary

This works take credit card transaction data to find abnormality pattern, for the suspected fraud. The main data we use are the transaction table and credit_card table.

The method of data ingestion and query is PostgreSQL 11 (pgAdmin 4). 
- Create a Entity Relation Diagram using [Quick Database Diagrams](https://app.quickdatabasediagrams.com/#/d/S07TOx).
- Create a database homework-SQL
- Run SQL in create_schema.sql as a query at pgAdmin 4
- Import all the tables from csv into the database at pgAdmin 4
- Run SQL in part1_queries to create 3 views
- Build and run visual_data_analysis in python at Jupyter Notebook, using pd.read_sql 
- Build and run challenge in python at Jupyter Notebook

## Part 1

### Entity Relation Diagram

![ERD](Images/QuickDBD_Free_Diagram.png)

### Possible fraud trace of small transactions
Using groupby cardholders to count transactions less than $2.00, we found many possible fraud:

![Small_amount_counts](Images/small_amount_count.png)

However 26 small amount transactions in a year is also possible to be genuine. We should use other methods to find more indicators.

### Possible fraud trace of early morning large amount transactions
If we examine the large amount transactions between 9:00 and 10:00 AM, it could be another trace:

![Early_morning_trans](Images/early_morning_trans.png)

The `$`1,301 and `$`974 spends look suspecious as people usually do not buy expensive items early in the morning. They have whole day to make up mind. 

### Possible fraud trace looking at the small transactions by merchants
Then we speculate the merchants having the most small transactions, we get 7,6,6,5,5. The frequency for the whole year looks not high. 

The conclusion from these prelimiary analysis seems okay.

## Visualizing data for a better view

### Cardholder 2, 18

![cardholder_2](Images/cardholder_2_trans.png)

![cardholder_18](Images/cardholder_18_trans.png)

![combine_2_18](Images/cardholder_2_18_trans.png)

When we look at the two different patterns, it stands out that cardholder 18 has many spikes of spending which may suggest fraud.

### Cardholder 25

![cardholder_25](Images/cardholder_25_6_months.png)

There are many outliers here too. Almost every month there are 1 to 3 large amount spending, especially in June. There may be fraud involved. We should contact the cardholder to find out more.

## Detect outliners for any cardholder

- Python function get_outlier take cardholder id as input, using standard deviation method to find outliers 
- Python function get_outliers take cardholder id as input, using inter-quatile deviation method to find outliers.

