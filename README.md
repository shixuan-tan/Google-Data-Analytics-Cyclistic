# Background
For the case study, I'm taking up the role of a Junior Data Analyst under the marketing analyst team at Cyclistic, a bike-share company in Chicago. Cyclistic has more than 5,800 bikes and 600 docking stations in Chicago. Bikes can be unlocked from one station and returned to any other station in the system anytime. Currently, they have 2 membership types, namely Members and Casual users. Casuals are defined as users who purchase single-ride or full-day passes, while Members are users who purchase annual memberships.

# Ask
Based on the findings by the finance analysts at Cyclistic, they have concluded that members are more profitable than casual riders. The director of the marketing team, Moreno, believes that we should maximize annual members by converting casual riders. To support this effort, she has assigned the team to look into how annual members and casual riders differ, why casual riders would buy a membership and how digital media could affect their marketing tactics. I have been assigned to answer the first question: “How do annual members and casual riders use Cyclistic bikes differently?”

# Prepare
## Data source
I will be using Cyclistic's trip data collected in 2024 for this analysis and identify if there are any trends and patterns between Members and Casual users. The data used were downloaded from the source provided here, and have been made available by Motivate International Inc. under this license.

A key data constraint is the absence of personally identifiable information (PII) due to data privacy protocols. This prevents linking casual rider pass purchases to credit card details, limiting insights into repeat usage or residential proximity to the service area. This analysis is thus centered on observed anonymized ride patterns.

## Data Organisation
I've downloaded the 12 monthly data files for the months of Jan to Dec 2024, with the naming convention of `YYYYMM-divvy-tripdata`. Each file contains ride information recorded in that month, such as `ride_id`, `bike type`, `start` and `end times`, `start` and `end station names`, `IDs` and `locations`, and whether the ride was used by a `member` or a `casual user`.

# Process
I've chosen to use `SQL` on `Google's bigquery platform` to combine, clean and analyse the data for this analysis. This is because of the large amount of data (5,860,568 rows) that makes it impossible to analyse through `Microsoft Excel`, while `BigQuery` is able to handle the large amount of data.

After uploading the 12 files into separate tables with the naming convention “`YYYYMM-data`” under 1 “Cyclistic” dataset on `SQL`, I've merged the 12 tables into 1 combined table for “`2024_data`”. This table contains 5,860,568 rows for the entire year.

# Data-exploration
There are a total of 13 columns in the tables, with `ride_id` being the primary key:

# Key summary of observations:
* `ride_ID`: While no null values were present, I’ve observed that there were 3 duplicate `ride_IDs`. Furthermore, an inspection of `ride_ID` character lengths revealed that the majority were 16 characters long, with the exception of 2,053 IDs with fewer than 16 characters. These shorter `IDs` were assumed to be incorrect and were removed from the dataset during the cleaning process.
* `rideable_type`: The data contains 2 primary `rideable_types`: `electric bikes` and `classic bikes`. No cleaning was required for this column.
* `started_at`, `ended_at`: The columns provided trip start and end timestamps in `YYYY-MM-DD hh:mm:ss UTC` format. 3 new “`ride_length_second`”, “`ride_length_minute`” and “`ride_length_hour`” columns have been added to determine the total trip duration in second, minute and hour respectively. There were 2,133 trips that were longer than one day and 44,697 trips with a duration less than one minute or those with end time earlier than start time, and these 46,830 rows have been removed during the cleaning process.
* `start_station_name`, `end_station_name`: A total of 1,369,513 rows containing missing values for either start or end station names were removed. In addition, leading or trailing spaces were also removed to ensure data consistency for analysis.
* `start_station_id`, `end_station_id`: The columns show inconsistent character lengths and varying formats. As the corresponding `start_station_name` and `end_station_name` columns were sufficient for location-based analysis, the station `ID` columns are deemed as non-essential and were excluded from this analysis.
* `start_lat`, `start_lng`, `end_lat`, `end_lng`: These columns show the starting and ending geographical coordinates of the bike trips, and will be used to plot on a map in Tableau during the analysis. Additionally, I have removed 1 trip with at least one null value.
* `casual_member`: There are two distinct membership types: `member` and `casual`. No cleaning was required for this column.

# Data Cleaning Process
In summary, I performed the following key data cleaning steps:

* Removed invalid `ride_id` values that had fewer than 16 characters to ensure data integrity.
* Cleaned station names by trimming leading and trailing spaces from `start_station_name` and `end_station_name` to standardize entries.
* Removed rows with missing values in all columns for data completeness.
* Filtered out rides shorter than one minute or longer than one day, ensuring only valid rides were included.
* Added `ride_length_seconds`, `ride_length_minute`, `day_of_week`, `month`, `hour_of_day`, and `day_type` columns to facilitate deeper analysis of usage patterns.
* 1,416,343 rows were removed in total during this process.

# Analyze
To investigate the differences in how annual members and casual riders use Cyclistic bikes, data was queried from multiple relevant tables. This analysis then proceeded to visualize their distinct usage patterns across various dimensions in `Tableau`.

Firstly, at an overall level, I’ve looked into the proportion of rides used by the two membership types in 2024.

Members accounted for the majority or approximately two-thirds of rides, representing 63.8% of the total, while casual riders constituted the remaining 36.2%.

Similarly, I’ve also examined the overall average ride lengths in the bar graph below.

Casual riders tend to take longer rides, averaging 24 minutes, while members ride for a shorter average duration of 12 minutes, which is approximately half that of casual.

Next, I have compared the distribution of rideable types across members and casual users.

Both annual members and casual riders exhibit similar preferences for bike types, with `classic bikes` accounting for over 60% of all rides, `electric bikes` for approximately 35%, and `electric scooters` comprising the remainder.

Subsequently, I examined the monthly data for ride count and average ride length.

Ride Count: Both annual and casual riders exhibit strong seasonal usage, with ride counts significantly increasing from May to October and declining in the colder months. While casual rides peak from July to September, members maintain high usage through October before seeing a decline.

Ride Length: For casual riders, ride length peaks from May to July and gradually declines from August onwards, indicating longer leisure-oriented trips from late spring to early summer. In contrast, members’ ride lengths remain relatively consistent throughout the year, showing only a slight increase from May to October before dropping in the colder months.

Following this, I’ve looked into day-of-week trends for both ride count and average ride length.

Ride Count: Members’ usage peaks from Monday to Thursday, indicating routine commuting, then declines significantly over the weekend. In contrast, casual ridership sharply rises on weekends, with Saturday making the highest peak, suggesting primary use for leisure activities.
Ride Length: While both members and casuals experience longer ride durations on weekends compared to weekdays, this increase is notably more pronounced for casual riders. Members, in contrast, maintain a more consistent, slightly longer average ride length during weekends.

Next, I’ve analyzed the hourly usage patterns for ride count and average ride length.

Ride Count: Members exhibit distinct commuting spikes in the morning (7:00-9:00 AM) and evenings (4:00-7:00 PM), with usage dropping midday. In contrast, casual ride count increases gradually throughout the day, peaking at around 5:00PM, further confirming the leisure-heavy usage for casual riders.

Ride Length: While members' average ride lengths don't differ significantly throughout the day, casual riders' longest trips occur from 10:00 AM to 2:00 PM, with their shortest rides observed between 5:00 AM and 8:00 AM.

Based on the above findings, it can be concluded that casual riders travel approximately 2 times longer, but less frequently than members. These longer trips are primarily observed on weekends, during midday hours and through the spring and summer seasons, which indicates a usage pattern largely focused on leisure rides.

To further understand the distinct preference between members and casuals, I have analyzed the locations of their most frequently used starting and ending stations to identify key areas of concentrated activity for each membership type.

Members are more likely to begin their trips in the stations near downtown, universities and residential areas while casual riders begin their trips near leisure spots, such as parks, lakes, the harbor and aquarium.

Similarly for end stations, casual riders tend to end their journey near parks and recreational areas while members end their trips close to downtown and residential areas.

This further confirms that casual riders are primarily using bikes for leisure activities while members use them for their daily commutes.

# Summary of findings:

| Feature                   | Members                                                                                                                                                                                                                                | Casual riders                                                                                                                                                                                                                              |
| :------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Total Ride Count          | Account for 63.8% of all rides, indicating a volume approximately twice that of casual riders.                                                                                                                                         | Account for 36.2% of all rides, constituting approximately one-third of overall ridership.                                                                                                                                                 |
| Average Ride Length       | Shorter duration, averaging at 12.4 minutes.                                                                                                                                                                                         | Longer duration, averaging at 23.8 minutes (approximately twice of members).                                                                                                                                                             |
| Purpose of bike usage     | Primarily use bikes for daily commutes on weekdays, with heavier usage during peak hours in the morning (6-8AM) and evenings (4-7PM), consistent throughout the year.                                                                    | Mostly leisure-orientated, predominantly during mid-days on weekends, with peak season from late spring to early summer months.                                                                                                            |
| Preferred Locations       | Bike rentals’ start and end stations are concentrated near residential areas and the downtown.                                                                                                                                         | Tend to rent and return bikes near recreational sites such as parks, harbor, lakes and aquarium.                                                                                                                                         |

Based on these differentiating usage patterns, I recommend the following marketing and operational strategies to Moreno and her team, aimed at increasing annual memberships:

Introduce “Weekend Explorer Pass”
Create a new membership pass targeted towards weekend leisure users during the peak spring-summer months.
This pass can offer unlimited rides on weekends only, which charges a discounted rate as compared to multiple single rides. This will attract regular weekend users to convert into membership suited for their needs.

Launch Targeted Weekend On-site Promotions
Hold marketing booths and promotional events near top stations frequently used by casual riders on weekends of peak season, aimed at converting them to membership.
Staff can provide information on the new “Weekend Explorer Pass” (mentioned in point 1) or other annual membership benefits, and can potentially offer on-the-spot signup incentives to encourage membership conversions.

Optimise Bike Rebalancing for Weekend Leisure Demand
Implement a dynamic bike rebalancing program that anticipates and meets the weekend surge in casual ridership around leisure areas.
Cyclistic can consider reallocating bikes from residential or downtown areas to key leisure attractions on Friday evenings, and then shifting them back to high-demand commuter areas on Sunday nights.
Ensuring bike availability at the right time and location significantly enhances the user experience by providing reliable access when and where riders need bikes. This improved service reliability, in turn, makes converting to an annual membership more appealing.
