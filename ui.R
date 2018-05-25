library(shiny)
library(plotly)
library(dplyr)

colors <- list("Pink" = "#F9766E", "Blue" = "#619DFF", "Green" = "#01BA38")
features <- c(
  "popularity", "danceability", "energy", "key", "loudness", "mode", 
  "speechiness", "acousticness", "instrumentalness", "liveness", "valence",
  "tempo", "duration_ms"
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
      img(
        "",
        src = "https://media.tenor.com/images/815e1f3a5302d410759b588408461f0a/tenor.gif"
      )
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
        p("The following graph shows a comparison of the US top 50 songs and
          the global top 50 songs."),
        
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
        plotlyOutput("us_global")
      )
    )
  ), 
  
  # Create a tabPanel to show bar plot
  tabPanel(
    "About Us",
    titlePanel(
      h1("Meet the Team????",
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
  )
))
