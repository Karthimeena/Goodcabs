

SET SQL_MODE = ' ';
WITH contribution_percentage AS (
SELECT city_id,  		
        COUNT(city_id),
		ROUND(COUNT(city_id) / (SELECT count(city_id) from fact_trips) * 100, 2) as 'Contribution_Percentage'
FROM fact_trips 
GROUP BY city_id
),
Avg_fare as (
SELECT c.city_id, 
		city_name,
		COUNT(ft.trip_id) as 'total_trip',
        SUM(ft.fare_amount)/SUM(ft.distance_travelled_km) as 'avg_fare_per_km', 
        SUM(ft.fare_amount)/COUNT(ft.trip_id) AS 'avg_fare_per_trip' 
FROM fact_trips ft 
inner join dim_city c ON c.city_id = ft.city_id
group by c.city_id
) 
SELECT 	af.city_name as 'City_Name',
		af.total_trip as 'Total_Trips' , 
        af.avg_fare_per_km as 'Avg. Fare/Km', 
        af.avg_fare_per_trip as 'Avg. Fare/Trip', 
        cp.Contribution_Percentage as '%_Contribution_to_Total_Trips' FROM
Avg_fare af 
INNER JOIN contribution_percentage cp ON cp.city_id = af.city_id
ORDER BY af.total_trip DESC




