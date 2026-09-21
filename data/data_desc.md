# Midwest Airbnb Listings: Data Dictionary

**Dataset:** `listings` table in `midwest_airbnb.db` (SQLite), 14,887 rows and 29 columns
**Source:** Inside Airbnb (https://insideairbnb.com/get-the-data/), the detailed `listings.csv.gz` file for each of three regions: Chicago (snapshot 2026-07-20), Columbus (snapshot 2026-07-23), and Twin Cities MSA (snapshot 2026-07-21). Column meanings follow Inside Airbnb's data dictionary and assumptions (https://insideairbnb.com/data-assumptions/).
**Course:** ISA 401, Miami University

> One row is one listing that showed a nightly price on the snapshot date; listings with no price were dropped. Empty cells are stored as SQL `NULL`.

---

## Field Definitions
| Field | Type | Description |
|---|---|---|
| `city` | text | Which Inside Airbnb region the listing came from: `Chicago` (7,439 rows), `Columbus` (2,587), or `Twin Cities` (4,861). The Twin Cities file covers the Minneapolis-St. Paul metro area, not just the two cities. |
| `snapshot_date` | text | Date Inside Airbnb compiled the file, stored as an ISO text string, not a date: `2026-07-20` for Chicago, `2026-07-23` for Columbus, `2026-07-21` for Twin Cities. Every row of a city shares the same value. |
| `id` | text | Airbnb's listing id. Unique across the table (14,887 distinct values). Stored as text even though it looks numeric, so compare it to a quoted string. |
| `name` | text | Listing title as shown on Airbnb (for example "Tiny Studio Apartment 94 Walk Score"). Never empty. |
| `price` | real | Nightly price in U.S. dollars on the snapshot date, with the dollar sign and commas removed. Ranges from 2.56 to 11,412; never `NULL` (rows without a price were dropped). |
| `room_type` | text | Airbnb's four listing categories: `Entire home/apt` (11,652 rows), `Private room` (2,951), `Hotel room` (246), or `Shared room` (38). |
| `host_id` | text | Unique Identifier for each host with a listing, with the id representing each distinct host. Stored as text so it could be stored as an identifier. A host may operate multiple listings so the same `host_id` can appear on multiple rows|
|`host_name` | text | The first name of each host listed for a listing, may be name of an individual or organization. |
| `host_since` | text | The date when the host for the listing joined Airbnb. Some records contain NA, so it is stored as text. Can be used to determine how long the host has been on Airbnb.|
| `host_is_superhost` | text | A value that indicates whether the host is superhost status on the platform.`t` represents a host is Superhost, `f` means a host is not a Superhost, and `NULL` means status is unavailable.|
| `neighbourhood` | text | The neighborhood in which each listing is assigned to and helps to understand the geographic location and proximity of the listings in each city. The field is based on Inside Airbnb's `neighbourhood_cleansed` field and can be used to compare listings across neighborhoods.|
| `latitude` | real | Stored as a numeric value, as it represents the point of latitude where the listing is located. Used together with longitude to determine approximate location of the listing. |
| `longitude` | real | Stored as a numeric value, as it represents the point of longitude where the listing is located. Used together with latitude to determine approximate location of the listing. |
| `property_type` | text | Shows the type of property that each listing is characterized as. Types include "Entire rental unit", "Room in serviced apartment", "Private room in home", etc. |
| `accomomodates` | integer | This shows the maximum number of guests that the listing can hold. For example, a value of 4 signifies that the listing can accommodate up to 4 guests. |
| `bedrooms` | real | This represents the number of bathrooms each listing contains. Contains NA, as some listings may not have available bedroom information. A value of 2 represents that the listing has 2 bedrooms. |
| `beds` | real | This relates to bedrooms, but goes more specific into showing the number of beds available in the listing. Contains NA as some listings may not have available bed information. A value of 6 represents that the listing has 6 beds available. |
| `bathrooms_text` | text | Stored as text because it describes both the number and type of bathrooms in the listing. For example, `1 bath` or `1.5 baths`. The field can contain both numbers and descriptions. |
| `minimum_nights` | integer | This value represents the minimum number of nights a guest is required to book the listing for a reservation. A value of 2 means that a guest is required to stay for a minimum of 2 nights. |
| `availability_365` | integer | This number shows the number of days that the listing is available for booking within the next 365 days. These values range from 0 to 365, with a value representing the number of available listings. A higher value indicates more available days. |
| `number_of_reviews` | integer | Indicates the total cumulative amount of reviews a listing has received on the Airbnb platform over its lifetime as a listings. This represents an overall measure of a listing's review activity. |
| `number_of_reviews_ltm` | integer | Indicates the number of reviews a listing has received over the last 12 months. Where `number_of_reviews` measures reviews over the entire lifetime of the listing, `number_of_reviews_ltm` gives a more recent measure of review activity. |
| `first_review` | text | This is stored as an ISO-formatted date and may be `NULL`if a listing has never received a review. This value is meant to show the date when the listing received its first Airbnb review. |
| `last_review` | text | This value represents the date that a listing most recently was reviewed in Airbnb. This is stored as an ISO-formatted date and may be `NULL` if the listing has not received any reviews. |
| `review_scores_rating` | real | This value represents the listing's overall rating from guests who have stayed there over time. The rating takes a value on a 0-5 scale, and could be `NULL` if the listing is yet to have a rating. |
| `reviews_per_month` | real | This demonstrates the average number of reviews the listing receives on a monthly basis. This provides a measure of how frequent the listing is reviewed and may be `NULL` if unavailable. |
| `instant_bookable` | text | Determines whether guests have the ability to immediately book the listing without requiring host approval. `t` means instant booking is available and `f` means it is not. |
| `estimated_revenue_l365d` | real | Estimated revenue generated by the listing over the past 365 days, measured in USD. This is merely an estimate from the basis of available listing data and should not be treated as the actual revenue reported by Airbnb for a listing. |
| `amenities_count` | integer | This shows the number of amenities each listing has. This was computed by counting individual amenties included in the listing's amenities information. |




Two hints: `neighbourhood` is Inside Airbnb's `neighbourhood_cleansed` column, and `amenities_count` is not an Inside Airbnb column; it was computed for this course as the number of items in each listing's `amenities` list. Everything else keeps its Inside Airbnb name, so the data dictionary linked above explains it.
