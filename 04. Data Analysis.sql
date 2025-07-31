-- Data Analysis

--  overall cyclistic ridership by membership

SELECT  
member_casual,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY 
member_casual;

--  average ride length by membership

SELECT  
member_casual,
AVG(ride_length_minute) AS average_ride_length_min
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY 
member_casual;

--  rideable type distribution by membership

SELECT  
member_casual,
rideable_type,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY 
member_casual,
rideable_type;

--  monthly ride count by membership

SELECT
  month,
  member_casual,
  COUNT(*) AS number_of_rides
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY
  month,
  member_casual;

--  monthly average ride length by membership

SELECT
  month,
  member_casual,
  AVG(ride_length_minute) AS average_ride_length
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY
  month,
  member_casual;

--  day of week ride count by membership

SELECT  
day_of_week,
member_casual,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY 
day_of_week,
member_casual;

--  day of week average ride length by membership

SELECT  
day_of_week,
member_casual,
AVG(ride_length_minute) AS average_ride_length
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY 
day_of_week,
member_casual;

--  time of day ride count by membership

SELECT
  hour_of_day,
  member_casual,
  COUNT(*) AS number_of_rides
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY
  hour_of_day,
  member_casual
ORDER BY
  hour_of_day, 
  member_casual;

--  time of day average ride length by membership

SELECT
  hour_of_day,
  member_casual,
  AVG(ride_length_minute) as Avg_ride_length
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` 
GROUP BY
  hour_of_day,
  member_casual
ORDER BY
  hour_of_day, 
  member_casual;

--  start stations for members

SELECT 
start_station_name, 
AVG(start_lat) AS start_lat, 
AVG(start_lng) AS start_lng,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data`
WHERE
 member_casual = "member" 
GROUP BY
  start_station_name
ORDER BY
 number_of_rides DESC;

--  start stations for casuals

SELECT 
start_station_name, 
AVG(start_lat) AS start_lat, 
AVG(start_lng) AS start_lng,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data`
WHERE
 member_casual = "casual" 
GROUP BY
  start_station_name
ORDER BY
 number_of_rides DESC;

--  end stations for members

SELECT 
end_station_name, 
AVG(end_lat) AS end_lat, 
AVG(end_lng) AS end_lng,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data`
WHERE
 member_casual = "member" 
GROUP BY
  end_station_name
ORDER BY
 number_of_rides DESC;

--  end stations for casuals

SELECT 
end_station_name, 
AVG(end_lat) AS end_lat, 
AVG(end_lng) AS end_lng,
COUNT(*) AS number_of_rides
FROM `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data`
WHERE
 member_casual = "casual" 
GROUP BY
  end_station_name
ORDER BY
 number_of_rides DESC;
