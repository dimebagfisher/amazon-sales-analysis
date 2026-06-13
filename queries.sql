-- Запрос 1: Топ категорий по выручке
SELECT 
    category,
    SUM(amount) AS total_revenue,
    COUNT(*) AS orders_count
FROM AmazonSaleReport
WHERE amount IS NOT NULL
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;

-- Запрос 2: Выручка по месяцам
SELECT 
    SUBSTR(date, 4, 7) AS month,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(*) AS order_count
FROM AmazonSaleReport
WHERE amount IS NOT NULL
    AND CAST(SUBSTR(date, 4, 2) AS INTEGER) <= 12
GROUP BY month
ORDER BY month;

-- Запрос 3: Средний чек по категориям (JOIN)
SELECT 
    a.category,
    ROUND(AVG(a.amount), 2) AS avg_check,
    COUNT(*) AS orders_count
FROM AmazonSaleReport a
JOIN SaleReport s ON a.sku = s.sku_code
WHERE a.amount IS NOT NULL
GROUP BY a.category
ORDER BY avg_check DESC;

-- Запрос 4: Топ-10 городов по заказам
SELECT 
    ship_city,
    COUNT(*) AS orders,
    ROUND(SUM(amount), 2) AS revenue
FROM AmazonSaleReport
WHERE amount IS NOT NULL
    AND ship_city IS NOT NULL
GROUP BY ship_city
ORDER BY orders DESC
LIMIT 10;

-- Запрос 5: Топ-5 регионов по выручке
SELECT 
    ship_state,
    COUNT(*) AS orders,
    ROUND(SUM(amount), 2) AS revenue
FROM AmazonSaleReport
WHERE amount IS NOT NULL
GROUP BY ship_state
ORDER BY revenue DESC
LIMIT 5;