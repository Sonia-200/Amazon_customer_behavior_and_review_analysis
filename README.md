# 🛒 Amazon Customer Behavior & Review Analysis  
*Tools Used:*   Python · PostgreSQL · Power BI  



## 📌 Project Overview  
This project analyzes customer behavior and product review trends on Amazon. Starting from raw review data, built an end-to-end pipeline using Python for data cleaning, PostgreSQL for analysis, and Power BI for visualization — revealing key business insights that can inform marketing, product strategy, and pricing.



## 🔄 Workflow Summary  

### 1️⃣ Data Cleaning (Python)  
- Removed duplicates, handled missing values  
- Converted datatypes for columns like reviewTime, price, vote, overall  
- Renamed columns for clarity and exported the cleaned dataset as final_data.csv  

### 2️⃣ Data Exploration (PostgreSQL)  
Used advanced SQL to extract core metrics and generate actionable insights.

#### 📊 KPIs:  
- *Total Reviews:* 99,963  
- *Unique Reviewers:* 76,741  
- *Products Reviewed:* 1,937  
- *Categories Covered:* 28  

#### 🔍 Key Insights:  
- *Most Reviewed Product:* Tiffen 62mm & 58mm UV Protection Filter (4525 reviews)  
- *Top Category:* All Electronics (24,940 reviews)  
- *Lowest Rated Category:* Toys and Games (Avg Rating: 2)  
- *Most Active Reviewer:* “Amazon Customer” (2900+ reviews)  
- *Seasonal Trends:* Reviews peak in *January* and in the *year 2015*  
- *Pricing Insights:*
  - Price has *minimal impact on rating*
  - Price *does impact number of reviews*
  - *Video Games* = most expensive category  
  - *Health & Personal Care* = cheapest category  
- *Product Patterns:*
  - 400+ products have high ratings but very few reviews  
  - Some products show *increasing reviews year-over-year*

---

### 3️⃣ Data Visualization (Power BI)  
Created an interactive dashboard with the following features:

#### 🖼 Dashboard Highlights:  
- KPI cards for total reviews, products, reviewers, and categories  
- yearly review trend analysis  
- Category-wise breakdowns of average price and rating  
- Scatter plots to explore the relationship between rating, price, and review count  
- Dynamic slicers for category, rating, and year  
- Highlighted products with low price + high ratings, and vice versa  

> 📸 ![WhatsApp Image 2025-08-06 at 19 00 03_f23cf11c](https://github.com/user-attachments/assets/83ef78bd-3a18-4ed0-929c-7299127e3b53)




## 💼 Business Use Cases  
- Identify *underrated high-quality products*  
- Evaluate *category-level performance* over time  
- Track *seasonal review patterns*  
- Understand how *price influences visibility and feedback*  
- Spot potential for *targeted campaigns* or *pricing strategies*



## 🏆 Skills Demonstrated  
- Data cleaning and transformation (Python – pandas)  
- Advanced SQL (CTEs, window functions, aggregations, filtering)  
- Data modeling and KPIs generation  
- Dashboard design, storytelling, and user interactivity (Power BI)  
- Real-world problem-solving and insight generation  



## 📁 Project Structure

├── Data_cleaning_python_file │   └── data_cleaning(Customer_Behavior_Analysis).ipynb
├── Sql_scripts │   └── sql_query_script.sql
├── Power BI dashboard │   └── Amazon_customer_behavior_and_review_analysis_dashboard.pbix



## 📬 Contact  
*Sonia Saini*  
[LinkedIn](https://www.linkedin.com/in/sonia-saini-data)  




## ⭐ Final Notes  
This project showcases the complete data analyst skillset — from messy data to clean insights. It’s designed to be scalable and understandable, while answering real business questions using practical tools.
