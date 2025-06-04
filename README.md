# 📊 Retail Sales Dashboard

## 📁 Project Overview

The **Retail Sales Dashboard** is an end-to-end BI project that provides stakeholders with actionable insights on sales performance, profitability, customer behavior, and logistics efficiency. The solution was developed using **SQL**, **Python**, **Excel**, and **Power BI**, with a strong emphasis on data cleaning, modeling, and interactive visualization.

## 🎯 Objectives

- Track overall sales and profit trends
- Understand customer segmentation and behavior
- Identify best- and worst-performing products
- Analyze regional and shipping trends
- Demonstrate practical skills in SQL, Power BI, Excel, and Python

## 🛠️ Tools & Technologies

| Tool         | Purpose                                                                 |
|--------------|-------------------------------------------------------------------------|
| **SQL**      | Data cleaning, schema modeling, data extraction & aggregation           |
| **Python**   | Handling missing data and duplicates, filling missing Product IDs       |
| **Excel**    | Exploratory data analysis and pivot reporting                           |
| **Power BI** | Dashboard design, DAX measures, and report interactivity                |

## 🧾 Dataset Source

- **Kaggle – Superstore Dataset**
- Columns:  
  `Row ID, Order ID, Order Date, Ship Date, Ship Mode, Customer ID, Customer Name, Segment, Country, City, State, Postal Code, Region, Product ID, Category, Sub-Category, Product Name, Sales, Quantity, Discount, Profit`

## 🧱 Data Schema Modeling (SQL-Based)

![Model](/Outputs/schema/ERD.png)

To normalize and improve query efficiency, the flat sales dataset was broken down into **dimension and fact tables** using SQL:

### 🎯 Fact Table: `fact_sales`
| Column         | Description           |
|----------------|-----------------------|
| `Order ID`     | Foreign Key           |
| `Product ID`   | Foreign Key           |
| `Customer ID`  | Foreign Key           |
| `Order Date`   | Transaction date      |
| `Ship Date`    | Delivery date         |
| `Ship Mode`    | Delivery method       |
| `Sales`        | Revenue               |
| `Quantity`     | Number of units sold  |
| `Discount`     | Discount applied      |
| `Profit`       | Net gain/loss         |

### 📘 Dimension Tables
- `dim_customers` – Customer info and location data
- `dim_products` – Product ID, name, and category info
- `dim_orders` – Order dates and shipping mode

## 🧹 Data Cleaning in SQL

- **Date Conversion**
```sql
UPDATE sales
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');
```

- **Remove Duplicates**
```sql
CREATE TEMPORARY TABLE products_clean AS
SELECT `Product ID`, `Product Name`, `Category`, `Sub-Category`
FROM raw_products
GROUP BY `Product ID`;
```

- **Fix Missing Product IDs**
  - Used Python to detect and fill missing `Product ID`s.
  - Used SQL `INSERT` for reintegration into the database.

- **Null Handling**
```sql
DELETE FROM sales
WHERE `Product ID` IS NULL OR `Customer ID` IS NULL;
```

## 📈 Key Metrics (DAX in Power BI)

| Metric               | Formula                                      |
|----------------------|----------------------------------------------|
| **Total Sales**      | `SUM(Sales)`                                 |
| **Total Profit**     | `SUM(Profit)`                                |
| **Profit Margin %**  | `(SUM(Profit) / SUM(Sales)) * 100`           |
| **Customer Count**   | `DISTINCTCOUNT(Customer ID)`                 |
| **Avg Discount**     | `AVERAGE(Discount)`                          |


## 🗂️ Dashboard Structure

### 🔹 Page 1: Executive Overview
- KPIs: Sales, Profit, Profit Margin, Customers
- Region-wise performance map
- Monthly sales trend
- Sales overtime

### 🔹 Page 2: Product Insights
- Sales by Category & Sub-Category
- Product-level table
- Filters: Category, Sub-Category

### 🔹 Page 3: Customer Analytics
- Sales by Segment and Region
- Customer distribution

### 🔹 Page 4: Shipping Analysis
- Ship Mode usage
- Profit impact by shipping

### 🔹 Page 5: Regional Trends
- Profit heatmap by state
- Region-level bar chart

## 📝 Project Contributions

- ✅ Normalized flat file into star schema with SQL
- ✅ Filled missing `Product IDs` using Python and SQL merge
- ✅ Built interactive Power BI dashboard
- ✅ Implemented custom DAX metrics
- ✅ Storyboarded insights from raw data to visualization

## 📎 Screenshots
**Executive Overview**
![Model](/Outputs/output/dash1.png)
**Product Insights**
![Model](/Outputs/output/dash2.png)
**Customer Analytics**
![Model](/Outputs/output/dash3.png)
**Shipping Analysis**
![Model](/Outputs/output/dash4.png)
**Regional Trends**
![Model](/Outputs/output/dash5.png)


## 📬 Contact

- Email: **awumadaniel015@gmail.com**
- LinkedIn: [https://www.linkedin.com/in/daniel-awuma-23201b22a/](#)
