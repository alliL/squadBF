# used Rspotify library to access Spotify API
# see documentation here: https://www.r-bloggers.com/my-new-r-package/
library(Rspotify)

# sourcing credentials such as client ID and client secret
source("api_key.R")

# set credentials for the Spotify API
# first parameter: the name of your spotify application
# second parameter: your Client ID, set this in your own api_key.R
# third parameter: your Secret Client, set this in your own api_key.R
keys <- spotifyOAuth("Song Analysis", client_id, client_secret)

# get features for songs in the playlist
get_playlist_features <- function(playlist_user, playlist_ID) {
  # get playlist
  playlist <- getPlaylistSongs(playlist_user, playlist_ID, token = keys)
  
  # get playlist features
  raw_playlist_features <- list()
  for (row_num in 1:nrow(playlist)) {
    song <- playlist[row_num, ]$id
    raw_playlist_features[[row_num]] <- getFeatures(song, token=keys)
  }
  playlist_features_only = do.call(rbind, raw_playlist_features)
  
  # combine playlist and playlist features
  playlist <- full_join(playlist, playlist_features_only)
  return(playlist)
}

# Some playlist examples to get started.
# To get the "playlist user" and "playlist ID", right click on a spotify
# playlist and go to 'Share' > 'Copy Spotify URI'
mood_booster <- get_playlist_features("spotify", "37i9dQZF1DX3rxVfibe1L0")
US_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbLRQDuF5jeBp")
global_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbMDoHDwVN2tF")
