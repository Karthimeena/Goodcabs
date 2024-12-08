

WITH Trips AS (
SELECT 	ft.city_id,
		c.city_name, 
        monthname(ft.date) AS trip_month, 
        COUNT(ft.trip_id) as 'actual_trips', 
        (tt.total_target_trips) as 'Target_trips', 
        COUNT(ft.trip_id)- (tt.total_target_trips) as 'difference' FROM trips_db.fact_trips ft
INNER JOIN targets_db.monthly_target_trips tt ON tt.city_id = ft.city_id AND MONTH(tt.month) = MONTH(ft.date)
INNER JOIN trips_db.dim_city c ON c.city_id = ft.city_id
INNER JOIN trips_db.dim_date d ON d.date = ft.date
GROUP BY ft.city_id, month(ft.date)
)
SELECT 	t.city_name AS 'City_Name', 
		t.trip_month as 'Month_Name', 
        t.actual_trips, 
        t.Target_trips,   
CASE 
	WHEN t.actual_trips > t.Target_trips THEN 'Above Target'
    WHEN t.actual_trips < t.Target_trips THEN 'Below Target'
END AS 'Performance_Status',
ROUND((t.difference/t.Target_trips) * 100,2) AS '%_difference' FROM Trips t




