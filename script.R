library(httr)
library(jsonlite)

source("api_key.R")

endpoint <- "https://api.spotify.com/v1/users/spotify/playlists/37i9dQZF1DX5nwnRMcdReF"
query_params <- list(client_id = spotify_id, response_type = "code",
                     redirect_uri= "https%3A%2F%2Fexample.com%2Fcallback")

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(endpoint, query = query_params)
parsed_data <- fromJSON(content(response, "text"))

View(parsed_data)

# SOMEONE HELP PLEASE
# https://beta.developer.spotify.com/documentation/web-api/quick-start/


# Top Tracks of 2017 URI
# spotify:user:spotify:playlist:37i9dQZF1DX5nwnRMcdReF