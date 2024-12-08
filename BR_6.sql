SET SQL_MODE = ' ';

WITH MonthlyRate AS (
	SELECT 
		fp.city_id,
		MONTHNAME(fp.month) as 'month_name', 
        fp.total_passengers, 
        fp.repeat_passengers, 
		ROUND((fp.repeat_passengers/fp.total_passengers) *100,2) AS 'monthly_repeat_pax_rate'
FROM fact_passenger_summary fp
),
CityRates AS (
	SELECT 
		fp.city_id,
		SUM(fp.total_passengers), 
        SUM(fp.repeat_passengers),
		ROUND((SUM(fp.repeat_passengers)/SUM(fp.total_passengers))*100,2 ) as 'city_repeat_pax_Rate'
FROM fact_passenger_summary fp
GROUP BY fp.city_id
)
SELECT city.city_name, m.month_name, m.total_passengers as 'total_passengers', m.repeat_passengers as 'repeat_passengers',  m.monthly_repeat_pax_rate, c.city_repeat_pax_Rate FROM MonthlyRate m
INNER JOIN  CityRates c ON c.city_id = m.city_id
INNER JOIN dim_city city ON city.city_id = m.city_id

