
# Project: E-Commerce Customer Segmentation & Funnel Analysis
### Tools: MySQL · Python · Tableau | Dataset: Olist Brazilian E-Commerce (Kaggle)

---

## Project Overview
This project analyzes 100,000+ real e-commerce transactions from Olist, 
a Brazilian marketplace, to segment customers, identify revenue drivers, 
and surface actionable business insights. The analysis spans the full 
analytics stack — from raw data ingestion in MySQL, to machine learning 
in Python, to an interactive Tableau dashboard.

---

## Business Questions Answered
- Which customer segments drive the most revenue?
- What is the platform's order delivery success rate?
- Which product categories generate the highest revenue?
- How do customer clusters differ in spending and recency?
- What does customer sentiment look like across review scores?

---

## Dataset
- **Source:** [Olist Brazilian E-Commerce Dataset — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size:** 99,441 orders · 96,478 delivered · 32,951 products · 3,095 sellers
- **Period:** 2016 – 2018
- **Tables used:** customers, orders, order_items, products, 
                   order_reviews, sellers

---

## Phase 1 — Data Engineering (MySQL)

Built a normalized MySQL database with 6 tables and foreign key constraints.
Handled real-world data quality issues including:
- Duplicate primary keys in order_reviews (resolved with IGNORE)
- Empty integer fields in products (resolved with NULLIF)
- Empty datetime fields in orders (resolved with NULLIF)
- Windows line ending characters in CSVs (\r warnings)
- Portuguese category names (resolved with a translation mapping table)

**Schema:**

customers → orders → order_items → products
→ order_reviews
→ sellers (via order_items)

---

## Phase 2 — SQL Analysis

### Key Findings

| Metric | Value |
|---|---|
| Total orders | 99,441 |
| Delivery rate | 97.02% |
| Cancellation rate | 0.63% |
| Top revenue category | Beauty & Health (R$1.23M) |
| Highest avg order value | Watches & Gifts (R$199) |

### Queries Built
- **RFM Scoring** — 3 layered views (rfm_base → rfm_scored → rfm_segments)
  using NTILE window functions to score customers 1–5 on Recency, 
  Frequency and Monetary value
- **Sales Funnel** — Order status distribution with percentage of total
- **Cohort Retention** — Monthly cohort analysis using CTEs
- **Top Sellers** — Revenue and avg review score per seller
- **Delivery Time by State** — Avg delivery days and satisfaction by region
- **Revenue by Category** — With Portuguese-to-English translation join

### RFM Segment Results

| Segment | Customers | Avg Spend | Avg Recency |
|---|---|---|---|
| Potential Loyalists | 45,377 | R$89.81 | 281 days |
| Loyal Customers | 36,268 | R$224.54 | 243 days |
| Lost | 5,456 | R$31.77 | 505 days |
| Needs Attention | 3,847 | R$61.30 | 520 days |
| Champions | 1,701 | R$338.15 | 180 days |

**Key Insight:** Champions represent only 2% of customers but have the 
highest spend and most recent purchases. Potential Loyalists (47%) 
represent the largest growth opportunity.

---

## Phase 3 — Python Analysis (Google Colab)

### Libraries Used
pandas · numpy · scikit-learn · matplotlib · seaborn

### K-Means Clustering
- Used elbow method and silhouette scoring to evaluate k=2 through k=8
- Mathematical optimum: k=2 (silhouette score 0.81)
- Business decision: overrode to k=4 for more actionable segmentation
- Final clusters: Low Value · Mid Value · High Value · Premium

### Sentiment Analysis
- TextBlob was evaluated but dropped — ineffective on Portuguese text
- Used star rating as sentiment proxy (industry standard workaround):
  - 4–5 stars → Positive (64.9%)
  - 3 stars → Neutral (8.7%)
  - 1–2 stars → Negative (26.5%)

### Charts Generated
1. RFM distributions (recency, frequency, monetary histograms)
2. Elbow curve + silhouette score for optimal k selection
3. Customer segment bar charts (count + revenue share)
4. Review sentiment pie chart + star rating distribution
5. Top 10 categories by revenue (horizontal bar)

---

## Phase 4 — Tableau Dashboard

**Live Dashboard:** [View on Tableau Public](#your-link-here)

### Charts in Dashboard
1. **Customer Segments** — Horizontal bar, sorted by count
2. **Revenue by Category** — Top 8 categories by total revenue
3. **Average Spend by Segment** — With overall average reference line
4. **Sentiment Distribution** — Pie chart (Positive / Neutral / Negative)
5. **Customer Clusters** — Scatter plot: recency vs avg spend, 
   sized by frequency, colored by cluster

---

## Key Business Insights

1. **97% delivery rate** is a strong operational metric for a marketplace 
   operating across Brazil's challenging geography

2. **47% of customers are Potential Loyalists** — the single biggest 
   revenue growth lever. A targeted re-engagement campaign could 
   meaningfully shift revenue

3. **Champions (2% of customers)** spend R$338 on average vs R$89 for 
   Potential Loyalists — 3.8x more valuable per customer

4. **Beauty & Health and Watches & Gifts** together account for over 
   R$2.4M in revenue — disproportionately high vs other categories

5. **26.5% negative sentiment** tied to 1–2 star reviews suggests 
   a meaningful post-purchase experience gap worth investigating

---

## Repository Structure

project-2-ecommerce-segmentation/
│
├── sql/
│   ├── phase1_schema.sql          # Database creation + table definitions
│   └── phase2_analysis.sql        # All analysis queries + RFM views
│
├── python/
│   └── phase3_analysis.ipynb      # Google Colab notebook
│
├── data/
│   ├── rfm_final.csv              # RFM scores + segments + clusters
│   ├── reviews_sentiment.csv      # Review scores + sentiment labels
│   └── revenue_by_category.csv   # Category revenue summary
│
├── charts/
│   ├── rfm_distributions.png
│   ├── optimal_k.png
│   ├── segment_analysis.png
│   ├── sentiment_fixed.png
│   └── revenue_by_category.png
│
└── README.md

---

## How to Reproduce

1. Download the Olist dataset from Kaggle
2. Run `sql/phase1_schema.sql` in MySQL Workbench to create the database
3. Load CSVs using LOAD DATA INFILE into the MySQL Uploads folder
4. Run `sql/phase2_analysis.sql` for all analysis queries
5. Open `python/phase3_analysis.ipynb` in Google Colab
6. Upload the exported CSVs and run all cells
7. View the live Tableau dashboard at the link above

---
---

## How to Reproduce

1. Download the Olist dataset from Kaggle
2. Run `sql/phase1_schema.sql` in MySQL Workbench to create the database
3. Load CSVs using LOAD DATA INFILE into the MySQL Uploads folder
4. Run `sql/phase2_analysis.sql` for all analysis queries
5. Open `python/phase3_analysis.ipynb` in Google Colab
6. Upload the exported CSVs and run all cells
7. View the live Tableau dashboard at the link above

---

*Part of a 3-project data analytics portfolio spanning finance, 
e-commerce, and travel domains.*
