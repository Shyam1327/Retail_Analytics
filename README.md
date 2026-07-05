
# 🛒 Retail Sales Analytics using SQL

---

## 📌 Project Overview

This project focuses on analyzing retail business data using SQL to extract meaningful insights from sales transactions, customer profiles, and product inventory data. The goal is to understand sales performance, customer behavior, and product trends to support data-driven business decisions.

By integrating multiple datasets, this project helps uncover patterns in customer purchasing behavior, identify top and low-performing products, and evaluate overall business performance. The insights generated can be used to improve inventory management, optimize marketing strategies, and enhance customer engagement.

---

## 🎯 Business Problem

The retail business is facing challenges in understanding its overall performance due to the lack of structured analysis of its data. Key issues include:

- Difficulty in identifying high-performing and low-performing products
- Limited understanding of customer purchasing behavior
- Lack of customer segmentation for targeted marketing
- Inefficient inventory management decisions
- Inability to track customer loyalty and repeat purchases

Without proper data analysis, the business struggles to make informed decisions that can improve revenue, customer satisfaction, and operational efficiency.

This project uses SQL to analyze transactional, customer, and product data to solve these challenges and generate actionable business insights.

---

## 🎯 Project Objectives

- Perform data cleaning and exploratory data analysis (EDA) using SQL to ensure data quality and extract meaningful insights.
- Identify high-performing and low-performing products based on sales performance.
- Segment customers based on purchasing behavior using the following classification:

| Total Quantity Purchased | Customer Segment |
|--------------------------|------------------|
| 0                        | No Orders        |
| 1 – 10                   | Low              |
| 11 – 30                  | Mid              |
| More than 30             | High Value       |

- Analyze customer purchasing behavior to identify repeat purchases and loyalty patterns.
- Support business decisions for marketing strategy, inventory management, and customer retention.

---

## 📁 Datasets Used

This project uses three related datasets:

### 🛍️ Sales Transactions
Contains transactional-level sales data including:
- Transaction ID  
- Customer ID  
- Product ID  
- Quantity Purchased  
- Transaction Date  
- Price  

### 👥 Customer Profiles
Contains customer information including:
- Customer ID  
- Age  
- Gender  
- Location  
- Join Date  

### 📦 Products Inventory
Contains product and stock-related information including:
- Product ID  
- Product Name  
- Category  
- Stock Level  
- Price  

---

## 🛠️ SQL Concepts Used

- SELECT statements  
- WHERE filtering  
- GROUP BY and HAVING clauses  
- ORDER BY sorting  
- Aggregate functions (SUM, COUNT, AVG, MIN, MAX)  
- JOINs (INNER JOIN, LEFT JOIN)  
- Common Table Expressions (CTEs)  
- Subqueries  
- CASE statements  
- Window functions    
- Date functions  

---

## 📊 Business Questions Answered

- Which products generate the highest and lowest sales?
- Which customers contribute the most revenue?
- Who are the repeat and high-value customers?
- Which products are underperforming or overstocked?
- How can customers be effectively segmented for marketing?
- What trends are visible in overall sales performance?
- Growth rate of Sales over the time

---

## 🚀 Conclusion

This project demonstrates how SQL can be used to transform raw retail data into meaningful business insights. By analyzing sales transactions, customer profiles, and product inventory, the project helps uncover patterns that support better decision-making.

The insights generated assist in improving sales performance, optimizing inventory, enhancing customer segmentation, and strengthening overall business strategy.
