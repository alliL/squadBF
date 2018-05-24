library(shiny)
library(ggplot2)
library(dplyr)

colors <- list("Pink" = "#F9766E", "Blue" = "#619DFF", "Green" = "#01BA38")

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
          "Random Test Slider", min = 0, max = 100, value = 50, step = 10
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
          "Random Test Slider", min = 0, max = 100, value = 50, step = 10
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
  )
))
