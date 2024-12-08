
SELECT city_name, Passenger, 'Top 3' as City_category
FROM (
    SELECT c.city_name, SUM(fps.new_passengers) AS Passenger
    FROM fact_passenger_summary fps
    INNER JOIN dim_city c ON c.city_id = fps.city_id
    GROUP BY c.city_name
    ORDER BY SUM(fps.new_passengers) DESC
    LIMIT 3
) AS top_cities
UNION ALL
SELECT city_name, Passenger, 'Bottom 3' as City_category
FROM (
    SELECT c.city_name, SUM(fps.new_passengers) AS Passenger
    FROM fact_passenger_summary fps
    INNER JOIN dim_city c ON c.city_id = fps.city_id
    GROUP BY c.city_name
    ORDER BY SUM(fps.new_passengers) ASC
    LIMIT 3
) AS bottom_cities;


