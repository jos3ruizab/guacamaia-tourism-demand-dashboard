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