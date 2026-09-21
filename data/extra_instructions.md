# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.
- `host_is_superhost` and `instant_bookable` are of the text value type 't' and 'f', not booleans
- When proving a city name, the user must match it to the `city` field using the city names in the data city: `Chicago`, `Twin Cities`, and `Columbus`. `Twin Cities`is data that represents the Minneapolis-St. Paul area.
- When searching for a listing by name, the `name` field should be searched case-insensitively so that capitalization differences do not create errors or prevent a listing from being found.
- When calculating an average `review_scores_rating`, do not include rows where `review_score_rating` is `NULL` since these listings do not have ratings available.


