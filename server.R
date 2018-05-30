# Load relevant libraries
library(shiny)
library(plotly)
library(dplyr)
library(Hmisc)

# Source in get playlist function
source("data_wrangling.R")

# Retrieve playlist function
# Some playlists to get started.
# To get the "playlist user" and "playlist ID", right click on a spotify
# playlist and go to 'Share' > 'Copy Spotify URI'
US_top_50 <- get_playlist_features("spotifycharts", "37i9dQZEVXbLRQDuF5jeBp")
global_top_50 <- get_playlist_features("spotifycharts",
                                       "37i9dQZEVXbMDoHDwVN2tF")
feature_descriptions <- read.csv("data/feature_descriptions.csv")

# Make function which takes in audio features from "global_top_50"
# and shows a bubble chart the artists, track names, popularity, and selected feature.
# Set color and size of the bubbles by popularity.
bubble_plot <- function(feature){
  p <- plot_ly(global_top_50, x = ~get(feature), y = ~artist,
               color = ~popularity,
               colors = "Set3", size = ~popularity,
               type = "scatter", mode = "markers",
               sizes = c(10, 40), marker = list(opacity = 0.85,
                             sizemode = "diameter"), hoverinfo = "text",
               text = ~paste0("Artist: ", artist, "<br>Track: ", tracks,
                              "<br>Popularity: ", popularity,
                              "<br>", capitalize(feature), ": ",
                              get(feature))) %>%
    layout(title = paste0(capitalize(feature), " of Global Top 50 Songs"),
           margin = list(l = 150, r = 10, b = 30, t = 30),
           xaxis = list(title = capitalize(feature), showgrid = FALSE),
           yaxis = list(title = "Artist", showgrid = FALSE))
  return(p)
}

# US top 50 popularity vs feature
us_bubble_plot <- function(feature){
  p <- plot_ly(US_top_50, x = ~get(feature), y = ~artist,
               color = ~popularity,
               colors = "Set3", size = ~popularity,
               type = "scatter", mode = "markers",
               sizes = c(10, 40), marker = list(opacity = 0.85,
                                                sizemode = "diameter"), hoverinfo = "text",
               text = ~paste0("Artist: ", artist, "<br>Track: ", tracks,
                              "<br>Popularity: ", popularity,
                              "<br>", capitalize(feature), ": ",
                              get(feature))) %>%
    layout(title = paste0(capitalize(feature), " of US Top 50 Songs"),
           margin = list(l = 150, r = 10, b = 30, t = 30),
           xaxis = list(title = capitalize(feature), showgrid = FALSE),
           yaxis = list(title = "Artist", showgrid = FALSE))
  return(p)
}

# Search for an artist
search_Artists <- function(words) {
  artistName <- words
  searching <- searchArtist(artistName, token = keys)
  new_data <- searching %>%
    select(display_name, popularity, followers, genres)
  return(new_data)
}

shinyServer(function(input, output) {
  # US top 50 vs. Global top 50
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

  # Display output
  output$feature_descriptions <- renderTable(feature_descriptions)

  output$feature_bubble <- renderPlotly({
    return(bubble_plot(input$feature))
  })
  
  output$US_plot <- renderPlotly({
    return(us_bubble_plot(input$feature))
  })
  
  output$hi_plot <- renderPlotly({
    return(random_plot(input$feature))
  })
  
  # Display the text search widget
  output$value <- renderPrint({input$text })
  
  output$searchArtists <- renderTable({
    return(search_Artists(input$text))
  })
    

})