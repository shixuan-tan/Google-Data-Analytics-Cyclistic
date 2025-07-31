# Google Data Analytics Capstone Project: Cyclistic 

# Introduction
This repository contains my capstone project for the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics). 
I have applied the data analysis process (Ask, Prepare, Process, Analyze, Share and Act) to address a business question for a bike-share company, Cyclistic. By utilizing SQL for data cleaning, Tableau and Excel for visualization, I will provide data-driven insights and actionable recommendations.
  
# Background
For the case study, I'm taking up the role of a Junior Data Analyst under the marketing analyst team at Cyclistic, a bike-share company in Chicago. Cyclistic has more than 5,800 bikes and 600 docking stations in Chicago. Bikes can be unlocked from one station and returned to any other station in the system anytime. Currently, they have 2 membership types, namely Members and Casual users. Casuals are defined as users who purchase single-ride or full-day passes, while Members are users who purchase annual memberships.

# Ask
Based on the findings by the finance analysts at Cyclistic, they have concluded that members are more profitable than casual riders. The director of the marketing team, Moreno, believes that we should maximize annual members by converting casual riders. To support this effort, she has assigned the team to look into how annual members and casual riders differ, why casual riders would buy a membership and how digital media could affect their marketing tactics. I have been assigned to answer the question: “How do annual members and casual riders use Cyclistic bikes differently?”

# Prepare
## Data source
I will be using Cyclistic's trip data collected in 2024 for this analysis and identify if there are any trends and patterns between Members and Casual users. The data used were downloaded from the source provided [here](https://divvy-tripdata.s3.amazonaws.com/index.html), and have been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).

Due to data privacy protocols, personally identifiable information (PII) is not available in the dataset. This constraint prevents us from determining if casual riders are repeat users who have purchased multiple single passes. As a result, our analysis will be based solely on observed anonymized ride patterns to understand rider behavior.

## Data Organisation
I've downloaded the 12 monthly data files for the months of Jan to Dec 2024, with the naming convention of `YYYYMM-divvy-tripdata`. Each file contains ride information recorded in that month, which consists of columns `ride_id`, `bike type`, `started_at`, `ended_at`, `start_station_name`, `end_station_name`, `start_station_id`, `end_station_id` and `start_lat`, `start_lng`, `end_lat`, `end_lng` and `member_casual`.

# Process
I've chosen to use SQL on Google's bigquery platform to combine, clean and analyse the data for this analysis. This is because of the large amount of data (5,860,568 rows) that makes it impossible to analyse through Microsoft Excel, while BigQuery is able to handle the large amount of data.

SQL Queries can be found in the links below:  
[01. Data Combining](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/01.%20Combining%20Data.sql)  
[02. Data Exploration](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/02.%20Data%20Exploration.sql)  
[03. Data Cleaning](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/03.%20Data%20Cleaning.sql)  
[04. Data Analysis](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/04.%20Data%20Analysis.sql)  

After uploading the 12 files into separate tables under the naming convention “`YYYYMM-data`” under 1 “Cyclistic” dataset on SQL, I've merged the 12 tables into 1 combined table for “`2024_data`”. This table contains 5,860,568 rows for the entire year of 2024, and data combination query can be found [here](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/01.%20Combining%20Data.sql). 

## Data-exploration
There are a total of 13 columns in the tables, with `ride_id` being the primary key:
<img width="436" height="420" alt="schema_cyclistic" src="https://github.com/user-attachments/assets/abdc506e-8d73-4b5a-94ca-363b3161cb67" />

I began by conducting a preliminary data exploration on each column of the combined table to identify key cleaning requirements. The full pre-cleaning process, documented in SQL, can be viewed [here](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/02.%20Data%20Exploration.sql). 
Below is an example of the analysis of the `ride_id` column below:

<img width="966" height="274" alt="data-exploration-example" src="https://github.com/user-attachments/assets/aa94405f-0c07-4b84-86e4-11f3fd582780" />
<img width="330" height="180" alt="rideID_characters" src="https://github.com/user-attachments/assets/51578901-15d1-4ffd-8a25-622717c97434" />



### Key summary of observations:
* `ride_ID`: While no null values were present, I’ve observed that there were 3 duplicate `ride_ID`. Furthermore, an inspection of `ride_ID` character lengths showed that the majority were 16 characters in length, with the exception of 2,053 IDs with fewer than 16 characters. These shorter IDs were assumed to be incorrect due to the inconsistency and were removed from the data during the cleaning process.
* `rideable_type`: The data contains 3 primary `rideable_types`: electric bikes, electric scooters and classic bikes. No cleaning was required for this column.
<img width="384" height="108" alt="rideable_type" src="https://github.com/user-attachments/assets/3cfd0108-e7d4-46ac-a143-c30afc3ecf26" />

* `started_at`, `ended_at`: The columns provided trip start and end timestamps in `YYYY-MM-DD hh:mm:ss UTC` format. 3 new `ride_length_second`, `ride_length_minute` and `ride_length_hour` columns have been added to determine the total trip duration in seconds, minutes and hours respectively. 2,133 trips were longer than one day and 44,697 trips have trip durations less than one minute or with end time earlier than start time - a total of 46,830 rows have been removed during the cleaning process.
* `start_station_name`, `end_station_name`: A total of 1,369,513 rows containing missing values for either start or end station names were removed. In addition, leading and trailing spaces were also removed to ensure data consistency for the analysis.
* `start_station_id`, `end_station_id`: The columns show inconsistent character lengths and varying formats. As the corresponding `start_station_name` and `end_station_name` columns were sufficient to identify the station locations, the station ID columns were deemed as non-essential and excluded from this analysis.
* `start_lat`, `start_lng`, `end_lat`, `end_lng`: These columns show the starting and ending geographical coordinates of the bike trips, and will be used to plot on a map in Tableau during the analysis. Additionally, 1 trip with at least one null value on the coorindates was removed.
* `casual_member`: There are two distinct membership types: member and casual. No cleaning was required for this column.
<img width="386" height="82" alt="membership_type" src="https://github.com/user-attachments/assets/87e19316-9c01-42b7-b87a-bc677eae8e52" />


## Data Cleaning Process
In summary, I performed the following data cleaning steps:

* Removed invalid `ride_id` that had less than 16 characters.
* Cleaned station names by trimming leading and trailing spaces from `start_station_name` and `end_station_name` to standardize data entries.
* Removed rows with missing values in all columns.
* Filtered out rides shorter than one minute, longer than one day or with end time earlier than start time to ensure only valid rides were included.
* Added `ride_length_seconds`, `ride_length_minute`, `ride_length_hour`,`day_of_week`, `month` and `hour_of_day` columns to facilitate deeper analysis of usage patterns.
* 1,416,343 rows were removed in total during this process.

The queries used for this cleaning process can be viewed [here](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/03.%20Data%20Cleaning.sql). 
# Analyze/Share
To investigate the differences in how annual members and casual riders use Cyclistic bikes, data was queried in multiple relevant tables. This analysis then proceeded to visualize their distinct usage patterns across various dimensions in Excel and Tableau. The queries used for the Data Analysis can be viewed [here](https://github.com/shixuan-tan/Google-Data-Analytics-Cyclistic/blob/main/04.%20Data%20Analysis.sql). 

Firstly, at an overall level, I’ve looked into the proportion of rides used by the two membership types in 2024.
<img width="600" height="371" alt="Overall Cyclistic Ridership by Membership Type" src="https://github.com/user-attachments/assets/7442ee94-ba12-467b-9b51-3dc8b4e0c5b4" />

Members comprised roughly two-thirds of the rides at 63.8%, with casual riders accounting for the remaining 36.2%.

Similarly, I’ve also examined the overall average ride lengths in the bar graph below.
<img width="600" height="371" alt="Average Ride Length by Membership Type" src="https://github.com/user-attachments/assets/1d0b6f22-d0ea-43f7-a1aa-e4ea486fb7a6" />

Casual riders tend to take longer rides, averaging 23.8 minutes, while members ride for a shorter average duration of 12.4 minutes, which is approximately half that of casual.

Next, I have compared the distribution of rideable types across members and casual users.
<img width="1364" height="440" alt="Rideable Type" src="https://github.com/user-attachments/assets/a45aaab3-9230-4246-ad33-50b32aab1059" />

Both annual members and casual riders exhibit similar preferences for bike types, with classic bikes accounting for over 60% of all rides, electric bikes for approximately 35%, and electric scooters comprising the remainder.

Subsequently, I examined the monthly data for ride count and average ride length.
<img width="710" height="371" alt="Monthly Ride Count by Membership Type " src="https://github.com/user-attachments/assets/1d841896-fe93-4465-8cad-4e51dbfdbff8" />

**Ride Count:** Both annual and casual riders exhibit strong seasonal usage, with ride counts peaking in the late spring to summer months and declining in the colder months. Casual rides are highest from July to September, while members maintain high usage through October before tappering off.

<img width="710" height="371" alt="Monthly Average Ride Length by Membership Type " src="https://github.com/user-attachments/assets/7561dda2-320c-4ab9-8f46-a00f2bfabe96" />

**Ride Length:** For casual riders, ride length peaks from May to July and gradually declines from August onwards, indicating longer leisure-oriented trips from late spring to early summer. In contrast, members’ ride lengths remain relatively consistent throughout the year, showing only a slight increase from May to October before dropping in the colder months.

Following this, I’ve looked into day-of-week trends for both ride count and average ride length.
<img width="600" height="371" alt="Day of Week Ride Count by Membership Type" src="https://github.com/user-attachments/assets/31790082-ca25-4d17-8327-443ff0a6bc17" />

**Ride Count:** Members’ usage peaks from Monday to Thursday, indicating routine commuting, then declines significantly over the weekend. In contrast, casual ridership sharply rises on weekends, with Saturday making the highest peak, suggesting primary use for leisure activities.

<img width="600" height="371" alt="Day of Week Average Ride Length by Membership Type" src="https://github.com/user-attachments/assets/0c8e5271-4d99-43ed-9dbe-79d05cd98d12" />

**Ride Length:** While both members and casuals experience longer ride durations on weekends compared to weekdays, this increase is notably more pronounced for casual riders. Members, in contrast, maintain a more consistent, slightly longer average ride length during weekends.

Next, I’ve analyzed the hourly usage patterns for ride count and average ride length.
<img width="600" height="371" alt="Hourly Ride Count by Membership Type" src="https://github.com/user-attachments/assets/85741638-455a-4dae-ac0f-3b9a29f3b914" />

**Ride Count:** Members exhibit distinct commuting spikes in the morning (7:00-9:00 AM) and evenings (4:00-6:00 PM), with usage dropping midday. In contrast, casual ride count increases gradually throughout the day, peaking at around 5:00PM, further confirming the leisure-heavy usage for casual riders.

<img width="600" height="371" alt="Hourly Average Ride Length by Membership Type" src="https://github.com/user-attachments/assets/01cd3f5c-67ad-46a6-a442-a8e3ab05cb9e" />

**Ride Length:** While members' average ride lengths don't differ significantly throughout the day, casual riders' longest trips occur from 10:00 AM to 2:00 PM, with their shortest rides observed between 5:00 AM and 8:00 AM.

Based on the above findings, it can be concluded that casual riders travel approximately 2 times longer, but less frequently than members. These longer trips are primarily observed on weekends, during midday hours and through the spring and summer seasons, which indicates a usage pattern largely focused on leisure rides.

To further understand the distinct preference between members and casuals, I have analyzed the locations of their most frequently used starting and ending stations to identify key areas of concentrated activity for each membership type.
<img width="1249" height="999" alt="Start" src="https://github.com/user-attachments/assets/ef387ca3-af9f-4112-aefa-cf3199d36843" />

Members are more likely to begin their trips in the stations near downtown, universities and residential areas while casual riders begin their trips near leisure spots, such as parks, lakes, the harbor and aquarium.

<img width="1249" height="999" alt="End" src="https://github.com/user-attachments/assets/10094a49-d1c2-4bc8-9d22-791806a80f4b" />

Similarly for end stations, casual riders tend to end their journey near parks and recreational areas while members end their trips close to downtown and residential areas.

This further confirms that casual riders are primarily using bikes for leisure activities while members use them for their daily commutes.

## Summary of findings:

| Feature                   | Members                                                                                                                                                                                                                                | Casual riders                                                                                                                                                                                                                              |
| :------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Total Ride Count          | Account for 63.8% of all rides, indicating a volume approximately twice that of casual riders.                                                                                                                                         | Account for 36.2% of all rides, constituting approximately one-third of overall ridership.                                                                                                                                                 |
| Average Ride Length       | Shorter duration, averaging at 12.4 minutes.                                                                                                                                                                                         | Longer duration, averaging at 23.8 minutes (approximately twice of members).                                                                                                                                                             |
| Purpose of bike usage     | Primarily use bikes for daily commutes on weekdays, with heavier usage during commute hours in the morning (6-8AM) and evenings (4-6PM), with higher bike usage from spring to summer seasons.                                                                    | Mostly leisure-orientated, predominantly during mid-days on weekends, with peak season from late spring to early summer months.                                                                                                            |
| Preferred Locations       | Bike rentals’ start and end stations are concentrated near residential areas and the downtown.                                                                                                                                         | Tend to rent and return bikes near recreational sites such as parks, harbor, lakes and aquarium.                                                                                                                                         |

# Act
Based on these differentiating usage patterns, I recommend the following marketing and operational strategies to Moreno and her team, aimed at increasing annual memberships:

1. Introduce “Weekend Explorer Pass”
* Create a new membership pass targeted towards weekend leisure users during the peak spring-summer months.
* This pass offer a low-commitment option that appeals to weekend recreational riders and encourages them to convert into members. 

2. Launch Targeted Weekend On-site Promotions
* Organise marketing booths near top stations frequently used by casual riders on weekends of peak season.
* Staff can promote the new “Weekend Explorer Pass” and offer on-the-spot signup incentives to drive conversions.

3. Optimise Bike Rebalancing for Weekend Leisure Demand
* Implement a dynamic bike rebalancing program that anticipates and meets the weekend surge in casual ridership around leisure areas.
* Cyclistic can reallocate bikes from downtown/commuter areas to key leisure attractions on Friday evenings, and then shifting them back on Sunday nights.
* This ensures bike availability when and where casual riders need them, enhancing user experience and making membership more appealing.
