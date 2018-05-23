library(Rspotify)
library(dplyr)

source("api_key.R")

keys <- spotifyOAuth("Song Analysis", client_id, client_secret)
mood_booster <- getPlaylistSongs("spotify","37i9dQZF1DX3rxVfibe1L0",token=keys)

datalist <- list()
for (row_num in 1:nrow(mood_booster)) {
  song <- mood_booster[row_num, ]$id
  datalist[[row_num]] <- getFeatures(song, token=keys)
}

dataset = do.call(rbind, datalist)

View(dataset)