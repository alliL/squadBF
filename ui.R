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
    "Tab 1",
    titlePanel(
      h1("Hello",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    # Create sidebar layout
    sidebarLayout(

      # Side panel for controls
      sidebarPanel(
        style = "position:fixed;width:300px;color:cadetblue",
        # Add a select input for the x variable
        sliderInput(
          "slider",
          "Random Test Slider",
          min = 0, max = 100, value = 50, step = 10
        )
      ),

      # Create main panel to display scatter plot
      mainPanel(
        img(
          "",
          src = "https://media.tenor.com/images/815e1f3a5302d410759b588408461f0a/tenor.gif"
        )
      )
    )
  ),

  # Create a tabPanel to show bar plot
  tabPanel(
    "Tab 2",
    titlePanel(
      h1("World",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),

    # Create a sidebar layout
    sidebarLayout(

      # Create a sidebarPanel for controls
      sidebarPanel(
        style = "position:fixed;width:300px;color:cadetblue",

        # Add a select input for the state selection
        selectInput(
          "meter",
          label = "Happiness Meter",
          choices = c("sad", "meh", "happy!"),
          selected = "meh"
        ),
        # Add a selectInput that allows color selection
        sliderInput(
          "slider",
          "Random Test Slider",
          min = 0, max = 100, value = 50, step = 10
        )
      ),


      # Create a main panel to display bar charts
      mainPanel(
        img(
          "",
          src = "https://media.tenor.com/images/815e1f3a5302d410759b588408461f0a/tenor.gif"
        )
      )
    )
  ),

  # US vs. Global Top 50 Comparison
  tabPanel(
    "Us v.s. Global",
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
  )
))
