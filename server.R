library(shiny)
library(plotly)
library(dplyr)
library(Hmisc)

source("data_wrangling.R")

# Some playlists to get started.
# To get the "playlist user" and "playlist ID", right click on a spotify
# playlist and go to 'Share' > 'Copy Spotify URI'

# mood_booster <- get_playlist_features("spotify", "37i9dQZF1DX3rxVfibe1L0")
US_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbLRQDuF5jeBp")
global_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbMDoHDwVN2tF")
# top_tracks_2017 <- get_playlist_features("spotify", "37i9dQZF1DX5nwnRMcdReF")
feature_descriptions <- read.csv("data/feature_descriptions.csv")

# Make function which takes in audio features from "US_top_50"
# and shows a bubble chart the artists, track names, popularity, and selected feature.
# Set color and size of the bubbles by popularity.
bubble_plot <- function(feature){
  p <- plot_ly(global_top_50, x = ~get(feature), y = ~artist,
               color = ~popularity,
               colors = "Set3", size = ~popularity, type = "scatter", mode = "markers",
               sizes = c(10, 40), marker = list(opacity = 0.85,
                             sizemode = "diameter"), hoverinfo = "text",
               text = ~paste0("Artist: ", artist,"<br>Track: ", tracks,
                              "<br>Popularity: ", popularity,
                              "<br>", capitalize(feature), ": ", get(feature))) %>%
    layout(title = paste0(capitalize(feature), " of US Top 50 Songs"),
           margin = list(l = 150, r = 10, b = 30, t = 30),
           xaxis = list(title = capitalize(feature), showgrid = FALSE),
           yaxis = list(title = "Artist", showgrid = FALSE))
  return(p)
}

# US global popularity vs feature
shinyServer(function(input, output) {
  output$us_global <- renderPlotly({
    x <- input$x_var
    y <- input$y_var

    us_data <- US_top_50 %>% select(tracks, artist_full, x, y)
    us_data$type <- "US"

    global_data <- global_top_50 %>% select(tracks, artist_full, x, y)
    global_data$type <- "Global"

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
  output$feature_descriptions <- renderTable(feature_descriptions)
  output$feature_bubble <- renderPlotly({
    return(bubble_plot(input$feature))
  })
})