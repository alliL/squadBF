library(shiny)
library(plotly)
library(dplyr)

source("data_wrangling.R")

# Some playlists to get started.
# To get the "playlist user" and "playlist ID", right click on a spotify
# playlist and go to 'Share' > 'Copy Spotify URI'
# mood_booster <- get_playlist_features("spotify", "37i9dQZF1DX3rxVfibe1L0")
US_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbLRQDuF5jeBp")
global_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbMDoHDwVN2tF")
# top_tracks_2017 <- get_playlist_features("spotify", "37i9dQZF1DX5nwnRMcdReF")

shinyServer(function(input, output) {
  output$us_global <- renderPlotly({
    x <- input$x_var
    y <- input$y_var

    us_data <- US_top_50 %>% select(tracks, artist_full, x, y)
    us_data$type <- "US"

    global_data <- global_top_50 %>% select(tracks, artist_full, x, y)
    global_data$type <- "global"

    data <- rbind(us_data, global_data)

    plot_ly(
      data = data, type = "scatter", mode = "markers", x = ~ data[[x]],
      y = ~ data[[y]], color = ~ type,
      text = paste0(data$tracks, ", ", data$artist_full, "<br />", data$type)
    ) %>%
      layout(
        xaxis = list(title = x),
        yaxis = list(title = y)
      )
  })
})

