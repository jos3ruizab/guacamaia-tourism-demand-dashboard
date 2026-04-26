-- ==========================================
-- GUACAMAIA: Tourism Intelligence
-- SQL Analysis Layer
-- ==========================================


-- Monthly demand distribution

SELECT 
    arrival_date_month,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY arrival_date_month
ORDER BY total_bookings DESC;

-- Cancellation rate

SELECT 
    ROUND(AVG(is_canceled), 3) AS cancellation_rate
FROM bookings;


-- Top countries by bookings

SELECT 
    country,
    COUNT(*) AS bookings
FROM bookings
GROUP BY country
ORDER BY bookings DESC
LIMIT 10;


-- Demand by market segment

SELECT 
    market_segment,
    COUNT(*) AS bookings
FROM bookings
GROUP BY market_segment
ORDER BY bookings DESC;


-- Estimated revenue by month

SELECT 
    arrival_date_month,
    SUM(adr) AS estimated_revenue
FROM bookings
GROUP BY arrival_date_month
ORDER BY estimated_revenue DESC;


-- Cancellation rate by segment

SELECT 
    market_segment,
    ROUND(AVG(is_canceled), 3) AS cancellation_rate
FROM bookings
GROUP BY market_segment
ORDER BY cancellation_rate DESC;


-- Time series dataset for forecasting

SELECT 
    arrival_date,
    COUNT(*) AS bookings
FROM bookings
GROUP BY arrival_date
ORDER BY arrival_date;


-- Monthly trend with change vs previous month

SELECT 
    arrival_date_year,
    arrival_date_month,
    COUNT(*) AS bookings,
    LAG(COUNT(*)) OVER (
        ORDER BY arrival_date_year, arrival_date_month
    ) AS previous_month,
    COUNT(*) - LAG(COUNT(*)) OVER (
        ORDER BY arrival_date_year, arrival_date_month
    ) AS change_in_bookings
FROM bookings
GROUP BY arrival_date_year, arrival_date_month
ORDER BY arrival_date_year, arrival_date_month;


-- Top country per month

SELECT *
FROM (
    SELECT 
        arrival_date_month,
        country,
        COUNT(*) AS bookings,
        RANK() OVER (
            PARTITION BY arrival_date_month 
            ORDER BY COUNT(*) DESC
        ) AS rank
    FROM bookings
    GROUP BY arrival_date_month, country
)
WHERE rank = 1;


-- Booking behavior segmentation

SELECT 
    CASE 
        WHEN lead_time < 30 THEN 'Last Minute'
        WHEN lead_time BETWEEN 30 AND 90 THEN 'Planned'
        ELSE 'Early Booking'
    END AS booking_type,
    COUNT(*) AS bookings
FROM bookings
GROUP BY booking_type
ORDER BY bookings DESC;


-- Revenue contribution by segment

SELECT 
    market_segment,
    SUM(adr) AS revenue,
    ROUND(
        SUM(adr) * 100.0 / SUM(SUM(adr)) OVER (), 
        2
    ) AS revenue_pct
FROM bookings
GROUP BY market_segment
ORDER BY revenue DESC;