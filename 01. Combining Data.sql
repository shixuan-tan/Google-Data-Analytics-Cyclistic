-- To combine the 12 monthly data tables into one table consisting of all biketrip data from Jan 2024 to Dec 2024. 

CREATE TABLE `cyclistic-capstone-2024.Cyclistic.2024_data` AS
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202401-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202402-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202403-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202404-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202405-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202406-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202407-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202408-data` 
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202409-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202410-data`
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202411-data` 
UNION ALL
SELECT* FROM `cyclistic-capstone-2024.Cyclistic.202412-data` 
;

-- The combined table contains 5,860,568 rows. 

SELECT COUNT(*)
FROM `cyclistic-capstone-2024.Cyclistic.2024_data`;
