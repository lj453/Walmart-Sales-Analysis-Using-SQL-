# Walmart Sales Data Analysis

## Introduction

This project aims to delve into Walmart's sales data to uncover insights regarding top-performing branches, popular product lines, sales trends, and customer behavior. The dataset utilized is sourced from the Kaggle Walmart Sales Forecasting Competition.

## Objectives

The primary goal of this project is to extract actionable insights from the sales data, facilitating a deeper understanding of the factors influencing sales across different Walmart branches.

## Dataset Overview

- **Source**: Kaggle Walmart Sales Forecasting Competition
- **Contents**: Sales transactions from three Walmart branches located in Mandalay, Yangon, and Naypyitaw.
- **Structure**: 17 columns, 1000 rows covering invoice details, branch information, customer attributes, product details, pricing, and sales metrics.

## Analysis Scope

1. **Product Analysis**: Evaluate different product lines, identify top-performing ones, and pinpoint areas for improvement.
   
2. **Sales Analysis**: Examine sales trends to assess the effectiveness of sales strategies and suggest enhancements.
   
3. **Customer Analysis**: Segment customers, analyze purchasing patterns, and evaluate the profitability of customer segments.

## Methodology

1. **Data Wrangling**: Initial data inspection to handle null values followed by database setup and data insertion.
   
2. **Feature Engineering**: Introduce new columns like `time_of_day`, `day_name`, and `month_name` for deeper insights into sales patterns.
   
3. **Exploratory Data Analysis (EDA)**: Dive into the data to address specific business questions and objectives.

## Business Questions

### General

- Determine the number of unique cities in the dataset and associate each branch with its respective city.

### Product

- Identify the variety of product lines available and analyze payment methods.
- Discover the best-selling product lines and examine revenue trends by month.
- Investigate COGS and VAT by month and product line, as well as revenue distribution across cities.
- Classify product lines as "Good" or "Bad" based on sales performance compared to the average.
- Evaluate branch performance in terms of product sales compared to the average.
- Explore the most common product lines by gender and assess average ratings for each product line.

### Sales

- Analyze sales volume by time of day and weekday.
- Determine the most revenue-generating customer types and cities with the highest VAT rates.
- Investigate VAT contributions by customer type.

### Customer

- Determine the diversity of customer types and payment methods.
- Identify the predominant customer type and their purchasing behavior.
- Examine gender distribution among customers and across branches.
- Explore rating distribution across different times of day and weekdays.

## Revenue and Profit Calculations

Revenue and profit are calculated based on the cost of goods sold (COGS) and VAT. Gross margin percentage is computed as the ratio of gross income to total revenue.
