-- Data Cleaning 

-- creating new table "2024_cleaned_data" with clean data and addition of new columns

CREATE TABLE `cyclistic-capstone-2024.Cyclistic.2024_cleaned_data` AS
SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  TRIM(start_station_name) AS start_station_name,
  TRIM(end_station_name) AS end_station_name,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  member_casual,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_second,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minute,
  TIMESTAMP_DIFF(ended_at, started_at, HOUR) AS ride_length_hour,
  FORMAT_TIMESTAMP('%A', started_at) AS day_of_week, 
  FORMAT_TIMESTAMP('%H', started_at) AS hour_of_day, 
  FORMAT_TIMESTAMP('%B', started_at) AS month_name,  
  CASE
    WHEN FORMAT_TIMESTAMP('%A', started_at) IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_data` 
WHERE
  LENGTH(ride_id) = 16 -- excluding ride_id with less than 16 characters 
  AND start_station_name IS NOT NULL
  AND end_station_name IS NOT NULL 
  AND start_lat IS NOT NULL
  AND start_lng IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
  AND (
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) >= 60 -- Excluding rides that are lesser than 1 min OR negative (error data)
    AND TIMESTAMP_DIFF(ended_at, started_at, SECOND) <= (24*60*60) -- Excluding rates that are longer than 1 day
  );

-- 1,416,343 rows were removed during this process
