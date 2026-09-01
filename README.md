# Airbnb Market Intelligence Dashboard

An end-to-end data analytics project analyzing short-term rental performance across 10 major US cities using MySQL and Tableau. The project covers data ingestion, SQL-based transformation and feature engineering, exploratory data analysis, and an interactive multi-view dashboard.


## Data
Source: airroi.com - Proprietary short-term rental market data covering Airbnb listings and monthly review activity.

Scope: 10 US cities - Austin, Boston, Chicago, Denver, Los Angeles, New York City, Phoenix, San Diego, Seattle, San Francisco.

Tables:

listings_{city} - one row per listing, containing property attributes, host details, pricing, ratings, and trailing twelve month (TTM) and last 90 day (L90D) revenue metrics \
reviews_{city} - one row per listing per month, containing monthly review counts and reviewer IDs

Raw CSV files are not included in this repo due to size. The SQL scripts assume these tables have been imported into a local MySQL database.

## Tools
MySQL	- Data storage, transformation, EDA \
MySQL Workbench -	Query execution and CSV export \
Tableau Public - Interactive dashboard

## Dashboard Views
The dashboard contains five interactive views, all cross-filtered by room type, bedrooms, and momentum signal:

Revenue by City	(Horizontal bar) -	AVG(ttm_revenue) by city \
Momentum by City	(100% stacked bar) - momentum_signal distribution per city \
Rating Heatmap	(Heatmap matrix) -	6 rating dimensions by city \
Rating vs Revenue Percentile	(Scatter plot) -	rating_overall vs revenue_percentile_in_city, sized by AVG(ttm_revenue), colored by momentum_signal \
Listing Map	(Symbol map) -	City-level bubbles sized by AVG(ttm_revenue), colored by momentum_signal \

## Key Findings
- Superhost status carries a measurable revenue premium in most markets, though the gap varies significantly by city
- Rating scores alone are a weak predictor of revenue percentile — the scatter plot shows low correlation between overall rating and market rank, suggesting pricing strategy and occupancy management matter more than guest satisfaction scores above a baseline threshold
- Momentum signals vary by market — some cities show a higher share of Rising listings indicating recent demand growth, while others skew Declining suggesting market saturation or seasonal softening
- RevPAR and ADR vary widely across cities — coastal markets like San Francisco and New York command significantly higher average daily rates but don't always lead on occupancy
