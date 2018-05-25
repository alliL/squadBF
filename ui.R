library(shiny)
library(plotly)
library(dplyr)

colors <- list("Pink" = "#F9766E", "Blue" = "#619DFF", "Green" = "#01BA38")
features <- list(
  "Danceability" = "danceability",
  "Energy" = "energy",
  "Key" = "key",
  "Loudness" = "loudness",
  "Mode" = "mode",
  "Speechiness" = "speechiness",
  "Acousticness" = "acousticness",
  "Instrumentalness" = "instrumenalness",
  "Liveness" = "liveness",
  "Valence" = "valence",
  "Tempo" = "tempo",
  "Duration (ms)" = "duration_ms"
)

shinyUI(navbarPage(
  "Spotify Playlist Analysis",

  # Create a tab panel for scatter plot
  tabPanel(
    "Home",
    titlePanel(
      h1("What can we learn using the Spotify API?",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    fluidPage(
      p("Using the",
        a("Rspotify",
          href = "https://www.r-bloggers.com/my-new-r-package/"
        ), "package to access Spotify API, we were able to analyze Spotify 
        playlists, artists, and features. Here is a list of song features:")
    )
  ),

  # US vs. Global Top 50 Comparison
  tabPanel(
    "US v.s. Global",
    titlePanel(
      h1("US Top 50 v.s. Global Top 50 Comparison",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    # Create sidebar layout
    sidebarLayout(

      # Side panel for controls
      sidebarPanel(
        style = "position:fixed;width:300px;color:cadetblue",

        # Add a select input for the x variable
        selectInput(
          "x_var",
          label = "X Variable",
          choices = features,
          selected = "popularity"
        ),
        # Add a select input for the y variable
        selectInput(
          "y_var",
          label = "Y Variable",
          choices = features,
          selected = "danceability"
        )
      ),

      # Create main panel to display scatter plot
      mainPanel(
        p(
          "The following graph lets you compare attributes of the",
          a("US Top 50",
            href = "https://open.spotify.com/user/spotifycharts/playlist/37i9dQZEVXbLRQDuF5jeBp"
          ), "playlist and the", a("Global Top 50",
            href = "https://open.spotify.com/user/spotifycharts/playlist/37i9dQZEVXbMDoHDwVN2tF"
          ), "playlist."
        ),

        plotlyOutput("us_global")
      )
    )
  ),

  # Create a tabPanel to show bar plot
  tabPanel(
    "About Us",
    titlePanel(
      h1("Meet the Team",
        style = "color:cadetblue;"
      )
    ),

    fluidPage(
      h3("Allison Lee"),
      h3("Brian Luu"),
      h3("Tiffany Truong"),
      h3("Maggie Wang"),
      h3("Kiley Wong")
    )
  ),
  
  tabPanel(
    "Feature v.s. Popularity",
    titlePanel(
               h1("Feature of Song and its relationship to Popularity",
                  style = "color:cadetblue;padding-bottom:20px"
               )),
    sidebarLayout(
      sidebarPanel(
        style = "position:fixed;width:300px;color:cadetblue",
        p("Select the interest of feature of songs, and it will return
          a bubble plot for the feature. One can see the relationship of
          the feature and the popularity of the songs."),
        selectInput(
          "feature",
          label = "Feature of the Song",
          choices = features
        )
      ),
      mainPanel(
        plotlyOutput("feature_bubble")
    )
    )
  )
))

