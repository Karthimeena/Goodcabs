
SET SQL_MODE = ' ';
WITH revenue AS (
SELECT c.city_name as 'city_name', 
		monthname(f.date) as 'Higest_revenue_month' , 
        SUM(f.fare_amount) as 'Revenue', 
        ROUND( (SUM(f.fare_amount) / (SELECT SUM(fare_amount) FROM fact_trips))*100,2) as 'Pecentage_contribution'
        FROM fact_trips f
INNER JOIN dim_city c ON c.city_id = f.city_id
group by c.city_name , monthname(f.date)
)
SELECT r.city_name, r.Higest_revenue_month, r.Revenue, r.Pecentage_contribution as 'Pecentage_contribution (%)' FROM revenue r
WHERE r.revenue = (SELECT MAX(r1.revenue) FROM revenue r1 WHERE r1.city_name = r.city_name)
 

