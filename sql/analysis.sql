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