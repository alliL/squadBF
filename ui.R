# Load relevant libraries
library(shiny)
library(shinythemes)
library(plotly)
library(dplyr)

# Set default colors
colors <- list("Pink" = "#F9766E", "Blue" = "#619DFF", "Green" = "#01BA38")

# Feature of Spotify songs
features <- list(
  "Popularity" = "popularity",
  "Danceability" = "danceability",
  "Energy" = "energy",
  "Key" = "key",
  "Loudness" = "loudness",
  "Mode" = "mode",
  "Speechiness" = "speechiness",
  "Acousticness" = "acousticness",
  "Instrumentalness" = "instrumentalness",
  "Liveness" = "liveness",
  "Valence" = "valence",
  "Tempo" = "tempo",
  "Duration (ms)" = "duration_ms"
)

# Main navigation
shinyUI(
  navbarPage(theme = shinytheme("sandstone"),
  "Spotify Playlist Analysis",
  # Tab for background info
  tabPanel(
    "Home",
    titlePanel(
      h1("What can we learn using the Spotify API?",
        align = "center",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    fluidPage(
      img("", src =
          "https://goo.gl/UUhG58"
      ), style="text-align: center;",
      p("Using the",
        a("Rspotify",
          href = "https://www.r-bloggers.com/my-new-r-package/"
        ), "package to access",
        a("Spotify API",
          href = "https://developer.spotify.com/documentation/web-api/"
        ), "we were able to analyze Spotify
        playlists, artists, and features. Here is a list of song features:"
      ),
      tableOutput("feature_descriptions")
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
          selected = "loudness"
        ),
        
        
        # Add a select input for the y variable
        selectInput(
          "y_var",
          label = "Y Variable",
          choices = features,
          selected = "speechiness"
        )
      ),

      # Create main panel to display scatter plot
      mainPanel(
        p("The following graph lets you compare attributes of the",
          a("US Top 50",
            href = "https://goo.gl/nkp9RD"
          ), "playlist and the", a("Global Top 50",
            href = "https://goo.gl/FRcPkL"
          ), "playlist."
        ),

        plotlyOutput("us_global")
      )
    )
  ),

  # Tab for feature vs popularity
  tabPanel(
    "Features of Songs",
    titlePanel(
      h1("Comparing Features of Songs to Popularity",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    sidebarLayout(
      sidebarPanel(
        style = "position:fixed;width:300px;color:cadetblue",
        p("Select the interest of feature of songs, and it will return
          a bubble plot for the feature. One can see the comparison of features
          , and compare betwwen Global chart and US chart."),
        selectInput(
          "feature",
          label = "X Variable",
          choices = features,
          selected = "key"
        ),
        selectInput(
          "feature2",
          label = "Y Variable",
          choices = features,
          selected = "energy"
        )
      ),
      mainPanel(
        plotlyOutput("feature_bubble"),
        br(), br(), br(),
        plotlyOutput("US_plot"),
        br(), br(), br(),
        p(style = "position:fixed;width:300px;color:cadetblue")
      )
    )
  ),

  # Tab for analysis of data and findings
  tabPanel(
    "Graph Analysis",
    h1("What do we learn from US Top 50 v.s. Global Top 50?",
       style = "color:cadetblue;padding-bottom:20px"),
    HTML('<img src="us_global.PNG"/>'),
        style="text-align: center;",
    p("This graph represents the playlists of the US Top 50 songs and Global 
      Top 50 songs on May 30, 2018. By looking at the relationship between 
      spechiness (presence of spoken words) and loudness (amplitude in 
      decibels) of these two playlists, we notice a grouping here. The top 50
      songs in the United States tend to be more 'speechy' than global top 50
      songs which are more loud than songs in the US playlist." ),
    h1("What do we learn from the relationship of features versus popularity?",
      style = "color:cadetblue;padding-bottom:20px"
    ),
    fluidPage(
      p(
        "When selecting feature and see its relationship with popularity,
        one can see that there are a few features which affect popularity,",
        strong("energy, speechiness, acoustincness, instrumentalness, and
               duration.")
      ),
      p(
        "However, when our team first viewed and run the data,",
        "there was an outlier, which is form artist", strong("A$AP Rocky.")
      ),
      img(
        src = "https://goo.gl/1NCzfN",
        height = 200, width = 200, align = "middle"
      ),
      p("Then we dug into the data we got from spotify, seeing that there were
        2 songs from the same artist with 0 popularity. There was obviously a
        problem with the data."),
      p(
        "First of all, since it says on", a("Spotify website",
          href = "https://goo.gl/KXm6n8"
        ),
        "that there are listeners from different areas every month,
        it is impossible that the popularity of this artist is",
        strong("zero.")
      ),
      p("Second of all, if the artist's popularity in Spotify's data is zero,
        how come it gets in Global Top 50 soundtrack provided by Spotify?"),
      p("Although while the list of Global Top Track keeps refreshing and those
        outliers got eliminated, we should still think about the issue of those
        outliers. It could be some companies are paying Spotify to make them be
        on the top list, and it could also be technical problems occurred in
        Spotify."),
      p("Despite the real reason, this is an important issue for us to
        think about, and also to rethink the credibility of Spotify.")
    )
  ),
  
  tabPanel(
    "Search Artists",
    titlePanel(
      h1("Search Your Favorite Artists!",
         style = "color:cadetblue;"
      )
    ),
      sidebarLayout(
        sidebarPanel(
          style = "position:fixed;width:300px;color:cadetblue",
          p("For the following, type your favorite artist. If there are spaces in the name
            use a '+' symbol"),
          #Search an artists first and last name
          textInput("text", label = h3("Type an Artist"),
                    value = "Regina + Spektor")
          ),
        mainPanel(
          p("Here you can search your favorite artists and see information about their music
            and popularity on Spotify."),
          tableOutput("searchArtists")
          )
        )
  ),

  # Tab for about the project makers
  tabPanel(
    "About Us",
    titlePanel(
      h1("Meet the Team",
        style = "color:cadetblue;",
        align = "center"
      )
    ),

    fluidPage(
      p("The project that we were working on is to show people information
        about spotify. We are using data from Rspotify and we are using that
        to show different visualizations of aspects such as danceability and
        popularity. The data that we have chosen is being used to show people
        statistics and facts about certain songs, and playslists."),
      h3("Allison Lee"),
      img(
        src = "Allison.png",
        height = 200, width = 200, align = "middle"
      ),
      p("Hi! I am currently a sophomore at the Universrity of Washington
        Seattle. My intended major is informatics and I am originally from
        Honolulu, Hawaii. I enjoy all kinds of food and I think
        that data structures and information is a big part of the
        evolving world."),
      h3("Brian Luu"),
      img(
        src = "Brian.jpg",
        height = 200, width = 200, align = "middle"
      ),
      p("Hello, I am a freshman at the University of Washington Seattle and
        a direct admit to the Information School,
        majoring in informatics.
        Hit me up on slack @Brian Luu!"),
      h3("Tiffany Truong"),
      img(
        src = "Tiffany.jpg",
        height = 200, width = 200, align = "middle"
      ),
      p("HI!! I am currently a freshman at the University of Washington
        Seattle. I am undecided on what I would like
        to pursue as a major at this time,
        but I do have an interest in informatics."),
      h3("Maggie Wang"),
      img(
        src = "Maggie.jpg",
        height = 270, width = 200, align = "middle"
      ),
      p("Helloo! I am a sophomore at UW-Seattle, and I'm a Communications
        major with Informatics minor!
        I'm from Taiwan and I love long coat German Shepards!"),
      h3("Kiley Wong"),
      img(
        src = "Kiley.jpg",
        height = 200, width = 200, align = "middle"
      ),
      p("Hi hi! I am a sophomore at the University Washington Seattle.
        My intended major is either
        Informatics or Human Centered Design and Engineering.
        I am originally from Southern California
        and enjoy eating and exploring!")
    )
  )
))
