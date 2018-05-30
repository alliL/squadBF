# Used Rspotify library to access Spotify API
# See documentation here: https://www.r-bloggers.com/my-new-r-package/
library(Rspotify)
library(dplyr)

# Sourcing credentials such as client ID and client secret
source("api_key.R")

# Set credentials for the Spotify API
# IMPORTANT: set the "Redirect URI". Go to your Spotify application on the
# web, go to "Edit Settings", and under "Redirect URIs", type 
# "http://localhost:1410/"
# First parameter: the name of your spotify application
# Second parameter: your Client ID, set this in your own api_key.R
# Third parameter: your Secret Client, set this in your own api_key.R
keys <- spotifyOAuth(app_id, client_id, client_secret)

# Get features for songs in the playlist
get_playlist_features <- function(playlist_user, playlist_ID) {
  # Get playlist
  playlist <- getPlaylistSongs(playlist_user, playlist_ID, token = keys)

  # Get playlist features
  raw_playlist_features <- list()

  for (row_num in 1:nrow(playlist)) {
    song <- playlist[row_num, ]$id
    raw_playlist_features[[row_num]] <- getFeatures(song, token = keys)
  }

  playlist_features_only <- do.call(rbind, raw_playlist_features)

  # Combine playlist and playlist features
  full_join(playlist, playlist_features_only)
}
