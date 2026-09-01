DROP TABLE IF EXISTS listings_all;

-- Step 1:Create one table with all listings
CREATE TABLE listings_all AS
SELECT "Austin" AS city, "Texas" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_austin
UNION
SELECT "Boston" AS city, "Massachusetts" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_boston
UNION
SELECT "Chicago" AS city, "Illinois" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_chicago
UNION
SELECT "Denver" AS city, "Colorado" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_denver
UNION
SELECT "Los Angeles" AS city, "California" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_la
UNION
SELECT "New York City" AS city, "New York" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_nyc
UNION
SELECT "Phoenix" AS city, "Arizona" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_phoenix
UNION
SELECT "San Diego" AS city, "California" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_sd
UNION
SELECT "Seattle" AS city, "Washington" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_seattle
UNION
SELECT "San Francisco" AS city, "California" AS state, listing_id,listing_name,listing_type, room_type, superhost, latitude, longitude, guests, bedrooms, beds, baths, amenities, professional_management, min_nights, cancellation_policy, num_reviews, rating_overall, rating_accuracy, rating_checkin, rating_cleanliness, rating_communication, rating_location, rating_value, ttm_revenue, ttm_avg_rate, ttm_occupancy, ttm_revpar, l90d_revenue FROM listings_sf;

-- Step 2: Create one table with all reviews, grouped by listing id with a sum of reviews for each listing

DROP TABLE IF EXISTS reviews_all;

CREATE TABLE reviews_all AS
WITH combinedreviews AS (
    SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_austin
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_boston
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_chicago
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_denver
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_la
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_nyc
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_phoenix
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_sd
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_seattle
	UNION
	SELECT listing_id, `date`, num_reviews, reviewers FROM reviews_sf
)
SELECT 
    listing_id as listing_id2, 
    SUM(num_reviews) AS total_reviews
FROM combinedreviews
GROUP BY listing_id;

-- Step 3: Join both tables together

DROP TABLE IF EXISTS master_table;
CREATE TABLE master_table AS
SELECT
    la.listing_id,
    la.city,
    la.state,
    la.listing_name,
    la.listing_type,
    la.room_type,
    la.superhost,
    la.latitude,
    la.longitude,
    la.guests,
    la.bedrooms,
    la.beds,
    la.baths,
    la.amenities,
    la.professional_management,
    la.min_nights,
    la.cancellation_policy,
    la.num_reviews,
    la.rating_overall,
    la.rating_accuracy,
    la.rating_checkin,
    la.rating_cleanliness,
    la.rating_communication,
    la.rating_location,
    la.rating_value,
    la.ttm_revenue,
    la.ttm_avg_rate,
    la.ttm_occupancy,
    la.ttm_revpar,
    la.l90d_revenue,
    ra.total_reviews
FROM listings_all la
LEFT JOIN reviews_all ra
    ON la.listing_id = ra.listing_id2;

SELECT * 
FROM master_table;

-- ============================================================
--  AIRBNB EDA + Tableau Queries
--  Table: master_table
-- ============================================================


-- ============================================================
--  PART 1: EDA — EXPLORATORY ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
--  1.1 Dataset overview — row counts and unique listings by city
-- ------------------------------------------------------------
SELECT
    city,
    state,
    COUNT(*)                        AS total_rows,
    COUNT(DISTINCT listing_id)      AS unique_listings,
    ROUND(AVG(total_reviews), 0)    AS avg_total_reviews
FROM master_table
GROUP BY city, state
ORDER BY unique_listings DESC;


-- ------------------------------------------------------------
--  1.2 Null check on key columns
-- ------------------------------------------------------------
SELECT
    COUNT(*)                                                        AS total_rows,
    SUM(CASE WHEN ttm_revenue IS NULL THEN 1 ELSE 0 END)           AS null_ttm_revenue,
    SUM(CASE WHEN ttm_occupancy IS NULL THEN 1 ELSE 0 END)         AS null_ttm_occupancy,
    SUM(CASE WHEN ttm_avg_rate IS NULL THEN 1 ELSE 0 END)          AS null_ttm_avg_rate,
    SUM(CASE WHEN rating_overall IS NULL THEN 1 ELSE 0 END)        AS null_rating_overall,
    SUM(CASE WHEN total_reviews IS NULL THEN 1 ELSE 0 END)         AS null_total_reviews,
    SUM(CASE WHEN bedrooms IS NULL THEN 1 ELSE 0 END)              AS null_bedrooms
FROM master_table;


-- ------------------------------------------------------------
--  1.3 Revenue distribution — bucketed into bands
--      Shows skew and spread of revenue across all listings
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN ttm_revenue >= 100000          THEN '100k+'
        WHEN ttm_revenue >= 75000           THEN '75k - 100k'
        WHEN ttm_revenue >= 50000           THEN '50k - 75k'
        WHEN ttm_revenue >= 25000           THEN '25k - 50k'
        WHEN ttm_revenue >= 10000           THEN '10k - 25k'
        ELSE                                     'Under 10k'
    END                                     AS revenue_band,
    COUNT(*)                                AS num_listings,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr
FROM master_table
WHERE ttm_revenue IS NOT NULL
GROUP BY revenue_band
ORDER BY MIN(ttm_revenue) DESC;


-- ------------------------------------------------------------
--  1.4 CTE: Market benchmarks per city + listing type
--      Computes avg and spread for key metrics per segment
-- ------------------------------------------------------------
WITH market_benchmarks AS (
    SELECT
        city,
        listing_type,
        COUNT(DISTINCT listing_id)              AS segment_listings,
        ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
        ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
        ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
        ROUND(AVG(ttm_revpar), 0)               AS avg_revpar,
        ROUND(AVG(rating_overall), 2)           AS avg_rating
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
    GROUP BY city, listing_type
)
SELECT *
FROM market_benchmarks
ORDER BY avg_ttm_revenue DESC;


-- ------------------------------------------------------------
--  1.5 CTE: Superhost revenue premium by city
--      How much more do superhosts earn vs non-superhosts?
-- ------------------------------------------------------------
WITH superhost_comparison AS (
    SELECT
        city,
        superhost,
        COUNT(DISTINCT listing_id)              AS num_listings,
        ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
        ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
        ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
        ROUND(AVG(rating_overall), 2)           AS avg_rating
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
    GROUP BY city, superhost
),
pivoted AS (
    SELECT
        city,
        MAX(CASE WHEN superhost = 'TRUE'  THEN avg_ttm_revenue END) AS superhost_revenue,
        MAX(CASE WHEN superhost = 'FALSE' THEN avg_ttm_revenue END) AS non_superhost_revenue,
        MAX(CASE WHEN superhost = 'TRUE'  THEN avg_occupancy_pct END) AS superhost_occupancy,
        MAX(CASE WHEN superhost = 'FALSE' THEN avg_occupancy_pct END) AS non_superhost_occupancy
    FROM superhost_comparison
    GROUP BY city
)
SELECT
    city,
    superhost_revenue,
    non_superhost_revenue,
    superhost_occupancy,
    non_superhost_occupancy,
    ROUND(superhost_revenue - non_superhost_revenue, 0)                         AS revenue_premium,
    ROUND((superhost_revenue - non_superhost_revenue)
        / NULLIF(non_superhost_revenue, 0) * 100, 1)                            AS revenue_premium_pct
FROM pivoted
ORDER BY revenue_premium DESC;


-- ------------------------------------------------------------
--  1.6 CTE + Window function: Revenue percentile rank
--      Ranks each listing within its city + bedroom segment
-- ------------------------------------------------------------
WITH ranked_listings AS (
    SELECT
        listing_id,
        listing_name,
        city,
        listing_type,
        bedrooms,
        ttm_revenue,
        ttm_avg_rate,
        ttm_occupancy,
        rating_overall,
        ROUND(
            PERCENT_RANK() OVER (
                PARTITION BY city, bedrooms
                ORDER BY ttm_revenue
            ) * 100, 1
        )                               AS revenue_percentile,
        ROUND(
            PERCENT_RANK() OVER (
                PARTITION BY city
                ORDER BY ttm_occupancy
            ) * 100, 1
        )                               AS occupancy_percentile
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
)
SELECT *
FROM ranked_listings
ORDER BY revenue_percentile DESC;


-- ------------------------------------------------------------
--  1.7 Window function: Running total revenue by city
--      Orders listings by revenue and shows cumulative share
-- ------------------------------------------------------------
WITH city_revenue AS (
    SELECT
        city,
        listing_id,
        listing_name,
        ttm_revenue,
        SUM(ttm_revenue) OVER (PARTITION BY city)                   AS city_total_revenue,
        SUM(ttm_revenue) OVER (
            PARTITION BY city
            ORDER BY ttm_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )                                                           AS running_total
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
)
SELECT
    city,
    listing_id,
    listing_name,
    ROUND(ttm_revenue, 0)                                           AS ttm_revenue,
    ROUND(city_total_revenue, 0)                                    AS city_total_revenue,
    ROUND(running_total / city_total_revenue * 100, 1)              AS cumulative_revenue_share_pct
FROM city_revenue
ORDER BY city, ttm_revenue DESC;


-- ------------------------------------------------------------
--  1.8 Window function: Momentum signal + LAG comparison
--      Classifies listings as Rising / Stable / Declining
--      and shows each listing vs city avg revenue
-- ------------------------------------------------------------
WITH momentum AS (
    SELECT
        listing_id,
        listing_name,
        city,
        listing_type,
        bedrooms,
        superhost,
        ttm_revenue,
        l90d_revenue,
        ttm_occupancy,
        rating_overall,
        total_reviews,
        ROUND((l90d_revenue / 90) * 365, 0)                         AS l90d_annualized,
        CASE
            WHEN (l90d_revenue / 90) * 365 > ttm_revenue * 1.10    THEN 'Rising'
            WHEN (l90d_revenue / 90) * 365 < ttm_revenue * 0.90    THEN 'Declining'
            ELSE                                                         'Stable'
        END                                                         AS momentum_signal,
        ROUND(AVG(ttm_revenue) OVER (PARTITION BY city), 0)         AS city_avg_revenue,
        ROUND(AVG(ttm_occupancy) OVER (PARTITION BY city), 3)       AS city_avg_occupancy
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
        AND l90d_revenue IS NOT NULL
)
SELECT
    *,
    ROUND(ttm_revenue - city_avg_revenue, 0)                        AS revenue_vs_city_avg,
    ROUND((ttm_revenue - city_avg_revenue)
        / NULLIF(city_avg_revenue, 0) * 100, 1)                     AS revenue_vs_city_avg_pct
FROM momentum
ORDER BY city, ttm_revenue DESC;


-- ------------------------------------------------------------
--  1.9 Rating dimensions vs revenue correlation
--      Does cleanliness matter more than location for revenue?
-- ------------------------------------------------------------
SELECT
    city,
    ROUND(AVG(rating_overall), 3)           AS avg_overall,
    ROUND(AVG(rating_cleanliness), 3)       AS avg_cleanliness,
    ROUND(AVG(rating_location), 3)          AS avg_location,
    ROUND(AVG(rating_value), 3)             AS avg_value,
    ROUND(AVG(rating_checkin), 3)           AS avg_checkin,
    ROUND(AVG(rating_communication), 3)     AS avg_communication,
    ROUND(AVG(rating_accuracy), 3)          AS avg_accuracy,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue
FROM master_table
WHERE rating_overall IS NOT NULL
GROUP BY city
ORDER BY avg_ttm_revenue DESC;


-- ============================================================
--  PART 2: TABLEAU VISUALIZATION-READY QUERIES
-- ============================================================


-- ------------------------------------------------------------
--  VIZ 1: KPI Summary Card
--  Use: Big number tiles at the top of the dashboard
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT listing_id)              AS total_listings,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
    ROUND(AVG(ttm_revpar), 0)               AS avg_revpar,
    ROUND(AVG(rating_overall), 2)           AS avg_rating,
    ROUND(AVG(total_reviews), 0)            AS avg_total_reviews
FROM master_table
WHERE ttm_revenue IS NOT NULL;


-- ------------------------------------------------------------
--  VIZ 2: Revenue & Occupancy by City — Bar Chart
--  Use: Side-by-side or ranked bar chart, one row per city
-- ------------------------------------------------------------
SELECT
    city,
    state,
    COUNT(DISTINCT listing_id)              AS num_listings,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
    ROUND(AVG(ttm_revpar), 0)               AS avg_revpar,
    ROUND(AVG(rating_overall), 2)           AS avg_rating
FROM master_table
WHERE ttm_revenue IS NOT NULL
GROUP BY city, state
ORDER BY avg_ttm_revenue DESC;


-- ------------------------------------------------------------
--  VIZ 3: Revenue by City + Bedroom Count — Heatmap or Matrix
--  Use: Matrix/heatmap with city on rows, bedrooms on columns
-- ------------------------------------------------------------
SELECT
    city,
    bedrooms,
    COUNT(DISTINCT listing_id)              AS num_listings,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND bedrooms IS NOT NULL
    AND bedrooms <= 6
GROUP BY city, bedrooms
ORDER BY city, bedrooms;


-- ------------------------------------------------------------
--  VIZ 4: Scatter Plot — Occupancy vs ADR sized by Revenue
--  Use: Scatter plot, color = momentum_signal, size = ttm_revenue
-- ------------------------------------------------------------
SELECT
    listing_id,
    listing_name,
    city,
    listing_type,
    room_type,
    bedrooms,
    superhost,
    ROUND(ttm_avg_rate, 0)                                          AS adr,
    ROUND(ttm_occupancy * 100, 1)                                   AS occupancy_pct,
    ROUND(ttm_revenue, 0)                                           AS ttm_revenue,
    ROUND(ttm_revpar, 0)                                            AS revpar,
    rating_overall,
    total_reviews,
    CASE
        WHEN (l90d_revenue / 90) * 365 > ttm_revenue * 1.10        THEN 'Rising'
        WHEN (l90d_revenue / 90) * 365 < ttm_revenue * 0.90        THEN 'Declining'
        ELSE                                                             'Stable'
    END                                                             AS momentum_signal
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND l90d_revenue IS NOT NULL
    AND ttm_avg_rate IS NOT NULL
    AND ttm_occupancy IS NOT NULL;


-- ------------------------------------------------------------
--  VIZ 5: Superhost Revenue Premium by City — Grouped Bar
--  Use: Grouped bar chart, superhost vs non-superhost per city
-- ------------------------------------------------------------
SELECT
    city,
    superhost,
    COUNT(DISTINCT listing_id)              AS num_listings,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
    ROUND(AVG(rating_overall), 2)           AS avg_rating
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND superhost IN ('TRUE', 'FALSE')
GROUP BY city, superhost
ORDER BY city, superhost;


-- ------------------------------------------------------------
--  VIZ 6: Rating Dimensions Heatmap by City
--  Use: Heatmap with city on rows, rating dimension on columns
-- ------------------------------------------------------------
SELECT
    city,
    ROUND(AVG(rating_overall), 2)           AS overall,
    ROUND(AVG(rating_cleanliness), 2)       AS cleanliness,
    ROUND(AVG(rating_location), 2)          AS location,
    ROUND(AVG(rating_value), 2)             AS value,
    ROUND(AVG(rating_checkin), 2)           AS checkin,
    ROUND(AVG(rating_communication), 2)     AS communication,
    ROUND(AVG(rating_accuracy), 2)          AS accuracy
FROM master_table
WHERE rating_overall IS NOT NULL
GROUP BY city
ORDER BY overall DESC;


-- ------------------------------------------------------------
--  VIZ 7: Momentum Signal Distribution by City — Stacked Bar
--  Use: 100% stacked bar, Rising/Stable/Declining per city
-- ------------------------------------------------------------
SELECT
    city,
    CASE
        WHEN (l90d_revenue / 90) * 365 > ttm_revenue * 1.10    THEN 'Rising'
        WHEN (l90d_revenue / 90) * 365 < ttm_revenue * 0.90    THEN 'Declining'
        ELSE                                                         'Stable'
    END                                                         AS momentum_signal,
    COUNT(DISTINCT listing_id)                                  AS num_listings
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND l90d_revenue IS NOT NULL
GROUP BY city, momentum_signal
ORDER BY city, momentum_signal;


-- ------------------------------------------------------------
--  VIZ 8: Cancellation Policy vs Performance — Bar Chart
--  Use: Ranked bar showing avg revenue by cancellation policy
-- ------------------------------------------------------------
SELECT
    cancellation_policy,
    COUNT(DISTINCT listing_id)              AS num_listings,
    ROUND(AVG(ttm_revenue), 0)              AS avg_ttm_revenue,
    ROUND(AVG(ttm_occupancy) * 100, 1)      AS avg_occupancy_pct,
    ROUND(AVG(ttm_avg_rate), 0)             AS avg_adr,
    ROUND(AVG(rating_overall), 2)           AS avg_rating
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND cancellation_policy IS NOT NULL
GROUP BY cancellation_policy
ORDER BY avg_ttm_revenue DESC;


-- ------------------------------------------------------------
--  VIZ 9: Revenue Percentile — Listing-Level Detail Table
--  Use: Filterable detail table or tooltip source in Tableau
-- ------------------------------------------------------------
WITH ranked AS (
    SELECT
        listing_id,
        listing_name,
        city,
        state,
		latitude,
        longitude,
        listing_type,
        room_type,
        bedrooms,
        superhost,
        professional_management,
        ROUND(ttm_revenue, 0)               AS ttm_revenue,
        ROUND(ttm_avg_rate, 0)              AS adr,
        ROUND(ttm_occupancy * 100, 1)       AS occupancy_pct,
        ROUND(ttm_revpar, 0)                AS revpar,
        rating_overall,
        rating_cleanliness,
        rating_location,
        rating_value,
        rating_checkin,
        rating_communication
        rating_accuracy,
        total_reviews,
        ROUND(
            PERCENT_RANK() OVER (
                PARTITION BY city, bedrooms
                ORDER BY ttm_revenue
            ) * 100, 1
        )                                   AS revenue_percentile_in_segment,
        ROUND(
            PERCENT_RANK() OVER (
                PARTITION BY city
                ORDER BY ttm_revenue
            ) * 100, 1
        )                                   AS revenue_percentile_in_city,
        CASE
            WHEN (l90d_revenue / 90) * 365 > ttm_revenue * 1.10    THEN 'Rising'
            WHEN (l90d_revenue / 90) * 365 < ttm_revenue * 0.90    THEN 'Declining'
            ELSE                                                         'Stable'
        END                                 AS momentum_signal
    FROM master_table
    WHERE ttm_revenue IS NOT NULL
        AND l90d_revenue IS NOT NULL
)
SELECT *
FROM ranked
ORDER BY revenue_percentile_in_city DESC;


-- ------------------------------------------------------------
--  VIZ 10: Map Layer — Lat/Long with Revenue + Momentum
--  Use: Filled map or symbol map in Tableau, one dot per listing
-- ------------------------------------------------------------
SELECT
    listing_id,
    listing_name,
    city,
    state,
    latitude,
    longitude,
    listing_type,
    bedrooms,
    ROUND(ttm_revenue, 0)                                           AS ttm_revenue,
    ROUND(ttm_avg_rate, 0)                                          AS adr,
    ROUND(ttm_occupancy * 100, 1)                                   AS occupancy_pct,
    rating_overall,
    superhost,
    CASE
        WHEN (l90d_revenue / 90) * 365 > ttm_revenue * 1.10        THEN 'Rising'
        WHEN (l90d_revenue / 90) * 365 < ttm_revenue * 0.90        THEN 'Declining'
        ELSE                                                             'Stable'
    END                                                             AS momentum_signal
FROM master_table
WHERE ttm_revenue IS NOT NULL
    AND l90d_revenue IS NOT NULL
    AND latitude IS NOT NULL
    AND longitude IS NOT NULL;
