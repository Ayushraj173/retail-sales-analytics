# 🛒 Retail Sales Analytics

## 📌 Project Overview

This project analyzes retail sales data to understand overall business performance, sales trends, product performance, customer behavior, sales channels, payment methods, discount patterns, and customer satisfaction.

The project uses **MySQL** for data cleaning and SQL-based business analysis and **Tableau Public** for interactive data visualization and dashboard development.

---

## 🎯 Business Objective

The main objective of this project is to transform messy retail sales data into meaningful business insights that can help answer questions such as:

- How is the business performing overall?
- Which products and categories generate the most revenue?
- Which products sell the highest quantity?
- Which cities and sales channels perform best?
- What are the customer purchasing patterns?
- Do discounts lead to higher sales?
- Which products have strong sales but lower customer ratings?
- What areas could provide opportunities for business improvement?

---

## 🛠️ Tools & Technologies

- **MySQL** – Data cleaning and SQL analysis
- **SQL** – Data transformation, aggregation, filtering, CTEs, and business analysis
- **Tableau Public** – Interactive dashboards and data visualization
- **CSV** – Source and cleaned data

---

## 🔄 Project Workflow

```text
Raw Retail Data
       ↓
Data Cleaning using MySQL
       ↓
Data Validation
       ↓
SQL Business Analysis
       ↓
Business Insights
       ↓
Tableau Visualization
       ↓
Interactive Dashboards
```


## 🧹 Data Cleaning

The original dataset contained several data-quality issues. MySQL was used to clean and standardize the data before analysis.

Key cleaning steps included:

- Removed duplicate order records.
- Standardized customer name fields.
- Trimmed unnecessary spaces from text fields.
- Cleaned phone number formatting.
- Converted negative quantities into positive values.
- Standardized payment method values.
- Standardized sales channel values.
- Corrected common email formatting issues.
- Handled missing customer email values.
- Standardized multiple order-date formats.
- Standardized city names.
- Corrected inconsistent city names such as Mumbai/Bombay and Bengaluru/Bangalore.
- Handled missing city values.
- Cleaned customer rating values.
- Created a cleaned dataset for further analysis and visualization.

The complete SQL cleaning and analysis queries are available in:

SQL/retail_messy_orders.sql

### Dataset

The project includes both the original messy dataset and the cleaned dataset used for analysis.

- `retail_orders_messy.csv` – Original dataset containing data-quality issues.
- `retail_orders_cleaned.csv` – Cleaned dataset prepared using MySQL for analysis and Tableau visualization.

## 📊 Tableau Dashboard

The project contains three interactive Tableau dashboards:

1. Sales Overview

Provides an overview of:

- Total Revenue
- Total Orders
- Total Customers
- Units Sold
- Monthly Revenue Trend
- Revenue by City
- Revenue by Category
- Revenue by Sales Channel
  
2. Product Performance

Analyzes:

- Top 10 Products by Revenue
- Top 10 Products by Quantity
- Revenue by Category
- Average Discount by Category
- Revenue vs Customer Rating
  
3. Customer & Channel Analysis

Analyzes:

- Top 10 Customers by Revenue
- Customer Count by City
- Orders by Sales Channel
- Average Order Value by Channel
- Payment Method Distribution
- City
- Sales Channel
- Product Category

### 🖼️ Dashboard Preview

#### Sales Overview

![Sales Overview](retail%20sales%20overview.png)

#### Product Performance

![Product Performance](product%20performance.png)

#### Customer & Channel Analysis

![Customer & Channel Analysis](CUSTOMER%20%26%20CHANNEL%20ANALYSIS.png)


## 🔍 Key Business Insights
### 💰 Overall Business Performance
- The business generated approximately ₹58.01 lakh in total revenue from 1,026 orders.
- A total of 2,418 units were sold across 292 unique customers.
- The overall Average Order Value (AOV) was approximately ₹5,654.30.
- The overall average customer rating was approximately 3.3/5, indicating an opportunity to improve customer satisfaction.
### 📈 Sales Trend
- March 2024 recorded the highest monthly revenue at approximately ₹4.32 lakh.
- August 2025 recorded the lowest monthly revenue at approximately ₹1.47 lakh, excluding records with missing order dates.
- The variation in monthly revenue indicates that sales performance changes over time and should be monitored to identify seasonal or business-specific trends.
### 🛍️ Product & Category Performance
- Home & Kitchen generated the highest category revenue at approximately ₹12.51 lakh.
- Beauty recorded the highest unit sales with 529 units sold.
- LED Lamp generated the highest product revenue at approximately ₹3.54 lakh.
- Sunscreen SPF50 was the highest-selling product by quantity with 129 units sold.
- Power Bank had the highest average selling price at approximately ₹3,087.50.
- Wireless Earbuds had the highest average customer rating at approximately 3.71/5.

These results show that the product generating the most revenue is not necessarily the product selling the highest number of units.

### 👥 Customer & Geographic Analysis
- Delhi generated the highest overall revenue among cities.
- Delhi also had the highest number of customers in the analysis.
- Neha Pillai placed the highest number of orders, with 10 orders.
- Hyderabad recorded the highest Average Order Value among cities.

This indicates that customer activity and spending behavior differ across locations.

### 🌐 Sales Channel Analysis
- ONLINE was the dominant sales channel.
- Online generated the highest revenue and order volume.
- Online recorded 647 orders.
- Online also had the highest Average Order Value compared with the other sales channels.

This makes the online channel an important driver of overall business performance.

### 💳 Payment Method Analysis
- UPI was the most commonly used payment method.
- The high usage of UPI highlights the importance of digital payment methods in the analyzed retail transactions.
### 🏷️ Discount Analysis
- Beauty had the highest average discount percentage among categories.
- A 5% discount recorded the highest Average Order Value among the discount levels analyzed.
- Higher discounts did not consistently result in higher sales volume.

This suggests that simply increasing discounts may not automatically increase sales.

Note: Discount analysis shows an observed relationship in the dataset and should not be interpreted as proof that discounts directly cause higher or lower sales.

### ⭐ Customer Rating & Product Performance
- The overall average customer rating was approximately 3.3/5.
- Wireless Earbuds had the highest average rating at approximately 3.71/5.
- Some products generated high revenue despite having relatively low customer ratings.
- Smartwatch was identified as a product with relatively strong sales volume but a lower average rating.

This highlights potential opportunities to investigate product quality, customer expectations, and overall customer experience.

## 💡 Business Recommendations

Based on the analysis, the following actions could help improve business performance:

1. Strengthen the Online Channel

Since online sales generate the highest revenue and order volume, the business should continue investing in its online customer experience and digital sales strategy.

2. Focus on High-Revenue Categories

Home & Kitchen is the strongest category by revenue. Inventory, product availability, and marketing efforts should be monitored closely for this category.

3. Leverage High-Volume Categories

Beauty generates the highest number of units sold. The business could explore ways to increase revenue per order within this category.

4. Investigate High-Revenue but Low-Rated Products

Products with strong sales but weaker customer ratings should be reviewed to identify potential issues related to product quality, pricing, or customer expectations.

5. Optimize Discount Strategies

Since higher discounts do not consistently produce higher sales, promotional strategies should be targeted rather than relying only on larger discounts.

6. Retain High-Value Customers

Customers with frequent purchases or high spending could be targeted through loyalty programs, personalized offers, and retention strategies.

7. Analyze Regional Opportunities

Delhi is the strongest revenue-generating city, while Hyderabad has the highest AOV. These markets could be analyzed further to understand the different factors driving customer spending.

8. Improve Customer Satisfaction

With an overall average rating of approximately 3.3/5, improving product quality and customer experience could help increase customer satisfaction and encourage repeat purchases.

## 📌 Key Takeaways
- Online sales are the primary revenue and order-volume driver.
- Home & Kitchen leads in revenue, while Beauty leads in unit volume.
- Delhi is the strongest revenue-generating city, while Hyderabad has the highest AOV.
- High sales do not always correspond to high customer ratings.
- Higher discounts do not consistently result in higher sales.
- The business has different groups of high-revenue and high-volume products, which should be managed according to business objectives.
- Customer satisfaction represents an opportunity for improvement.

## 📁 Repository Structure

```text
retail-sales-analytics/
│
├── README.md
├── retail_messy_orders.sql
├── Retail Sales Analytics Dashboard.twbx
├── retail_orders_messy.csv
├── retail_orders_cleaned.csv
├── CUSTOMER & CHANNEL ANALYSIS.png
├── product performance.png
└── retail sales overview.png
```
## 📂 Project Files

### SQL

The SQL file contains the complete data-cleaning process and business analysis queries.

**[View SQL Analysis](SQL/retail_messy_orders.sql)**

### Tableau

The Tableau packaged workbook contains the dashboards and visual analysis.

`Tableau/Retail Sales Analytics Dashboard.twbx`
## 👤 Author

**Ayush Raj**

Aspiring Data Analyst

### Skills Demonstrated

- MySQL
- SQL
- Data Cleaning
- Data Analysis
- Tableau
- Data Visualization
- Business Intelligence
- Business Insight Generation
