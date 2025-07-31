-- Data Exploration

-- overall checking for duplicated rows

SELECT
    *,
    COUNT(*) As RowCount
FROM
    `cyclistic-capstone-2024.Cyclistic.2024_data`
GROUP BY
    ride_ID, rideable_type, started_at, ended_at, start_station_name, start_station_id,
    end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
HAVING
    COUNT(*) > 1;

/* 
no duplicated rows found
*/

-- ride_ID - checking for duplicated rows

SELECT 
    ride_id,
    COUNT(ride_id) AS DuplicateCount
FROM
    `cyclistic-capstone-2024.Cyclistic.2024_data`
GROUP BY
    ride_ID
HAVING
    COUNT(ride_ID) > 1; 

/* 
3 sets of duplicated rows found - to be removed during cleaning
*/

-- ride_id - checking for character length

SELECT LENGTH(ride_ID) AS ride_ID_len,
COUNT(*) AS no_of_ID
FROM `cyclistic-capstone-2024.Cyclistic.2024_data` 
GROUP BY ride_ID_len;

/* 
majority are 16 characters except for 2,053 rows with less than 16 characters - to be removed during cleaning
*/

-- rideable_types - checking for rideable_types available

SELECT rideable_type,
COUNT(*) AS Number_of_types
FROM `cyclistic-capstone-2024.Cyclistic.2024_data` 
GROUP BY rideable_type;

/* 
3 unique bike trips - classic bike, electric bike and electric scooter
no cleaning required
*/

-- started_at, ended_at - to keep only rows that are longer than 1 min and shorter than one day

-- checking for rides that are lesser than 1 min OR with end date earlier than start date 

SELECT
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_second,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minute,
  TIMESTAMP_DIFF(ended_at, started_at, HOUR) AS ride_length_hour
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_data` 
WHERE
 TIMESTAMP_DIFF(ended_at, started_at, SECOND) < 60 
;

/* 
44,697 rows found with rides lesser than 1 min or error data with end date earlier than start date - to be removed during cleaning
*/

-- checking for trips that are longer than 1 day  

SELECT
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_second,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minute,
  TIMESTAMP_DIFF(ended_at, started_at, HOUR) AS ride_length_hour
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_data` 
WHERE
 TIMESTAMP_DIFF(ended_at, started_at, SECOND) > (24*60*60);

/* 
2,133 rows found with rides longer than 1 day - to be removed during cleaning
*/

-- start_station_name, end_station_name - checking for null values

SELECT
    COUNTIF(start_station_name IS NULL OR end_station_name IS NULL) AS Rows_With_Null_Station_Names
FROM
    `cyclistic-capstone-2024.Cyclistic.2024_data`;

/* 
1,369,513 rows with null values in either columns - to be removed during cleaning
*/

-- start_station_id, end_station_id - checking for character length 

SELECT
  LENGTH(start_station_id) AS station_id_length,
  COUNT(*) AS number_of_entries
FROM
  `cyclistic-capstone-2024.Cyclistic.2024_data`
WHERE
  start_station_id IS NOT NULL 
GROUP BY
  station_id_length
ORDER BY
  station_id_length;

/* 
inconsistent data with varying character lengths (2-14)
both columns will be excluded as they do not offer any value to the analysis
*/

-- start_lat, start_lng, end_lat, end_lng - checking for rows with null values

SELECT *
FROM `cyclistic-capstone-2024.Cyclistic.2024_data`
WHERE start_lat IS NULL OR
 start_lng IS NULL OR
 end_lat IS NULL OR
 end_lng IS NULL;

/* 
1 row with null value on either of the coordinates - will be removed during cleaning
*/

-- casual_member - checking for number of membership type

SELECT member_casual,
COUNT(*) AS Number_of_types
FROM `cyclistic-capstone-2024.Cyclistic.2024_data` 
GROUP BY member_casual;

/* 
2 unique membership type - member and casual
no cleaning is required
*/

-- now that we have checked the data, we are ready to proceed with the data cleaning and analysis
