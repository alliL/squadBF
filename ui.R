library(shiny)
library(plotly)
library(dplyr)

colors <- list("Pink" = "#F9766E", "Blue" = "#619DFF", "Green" = "#01BA38")
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

shinyUI(navbarPage(
  "Spotify Playlist Analysis",

  # Create a tab panel for scatter plot
  tabPanel(
    "Home",
    titlePanel(
      h1("What can we learn using the Spotify API?",
        align = "center",
        style = "color:cadetblue;padding-bottom:20px"
      )
    ),
    fluidPage(
      img(
        "",
        src = 
          "https://www.purplepandamedia.com/wp-content/uploads/2015/03/spotify-1.jpg"
      ),
      p(
        "Using the",
        a("Rspotify",
          href = "https://www.r-bloggers.com/my-new-r-package/"
        ), "package to access Spotify API, we were able to analyze Spotify 
        playlists, artists, and features. Here is a list of song features:"
      ),
      tableOutput('feature_descriptions')
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
  
  tabPanel(
    "Feature v.s. Popularity",
    titlePanel(
      h1("Feature of Song and its relationship to Popularity",
         style = "color:cadetblue;padding-bottom:20px"
      )
    ),
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
        plotlyOutput("feature_bubble"),
        p(style = "position:fixed;width:300px;color:cadetblue"
      )
    )
  )),
  
  tabPanel(
    "Analysis",
    h1("What do we learn from the relationship of feature versus popularity?",
       style = "color:cadetblue;padding-bottom:20px"
    ),
    fluidPage(
      p(
        "When selecting feature and see its relationship with popularity,
        one can see that most of the features don't really affect popularity
        except one feature, ", strong("ENERGY.")),
      p("From selecting the feature", strong("ENERGY."),
        "we are able to see that most of the song with higher popularity has higher energy."),
      p("However, when selecting", span(strong("popularity")),
        ", we can see that there is an outlier, which is form artist", span(strong("A$AP Rocky."))),
      img(src = "https://images.genius.com/0635bd3f246cb6af9c8aa48a06263c39.1000x1000x1.jpg",
          height = 200, width = 200, align = "middle"),
      p("Then we dig into the data we got from spotify, seeing that there are 2 songs from the same
        artist with 0 popularity. There is obviously a problem with the data."),
      p("First of all, since it says on", a("Spotify website", href = "https://open.spotify.com/artist/13ubrt8QOOCPljQ2FL1Kca/about"),
        "that there are listeners from different areas every month, it is impossible that the popularity
        of this artist is", strong("zero.")),
      p("Second of all, if the artist's popularity in Spotify's data is zero,
        how come it gets in Global Top 50 soundtrack provided by Spotify?"),
      p("This is an important issue for us to think about, and to rethink the credibility
        of Spoify.")
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
      p("The project that we were working on is to show that we have a god understanding of the r program.
        We are trying show that we are able to create a shiny application that uses a dataset of our choice.
        The data set that we have chosen to use is the Rspotify API. We are using data from spotify and we are
        using that to show differnt visualizations of the data."),
      h3("Allison Lee"),
      img(src = "https://i.pinimg.com/736x/31/c3/4f/31c34f9fefbb06074c45434b543f6e11--too-cute-puppies-puppies-cutest.jpg",
          height = 200, width = 200, align = "middle"),
      p("Hi! I am currently a sophomore at the Universrity of Washington Seattle. My intended major 
        is informatics and I am originally from Honolulu, Hawaii. I enjoy all kinds of food and I think 
        that data structures and information is a big part of the evolving world."),
      h3("Brian Luu"),
      img(src = "http://barkingroyalty.com/wp-content/uploads/2015/12/pomeraninan-puppy.jpg?x30644.jpg",
          height = 200, width = 200, align = "middle"),
      p("Hello, I am a freshman at the University of Washington Seattle and a direct admit ot the
        Information School, majoring in informatics. Hit me up on slack @Brian Luu!"),
      h3("Tiffany Truong"),
      img(src = "https://i.redd.it/51p5c1efueoy.jpg",
          height = 200, width = 200, align = "middle"),
      p("HI!! I am currently a freshman at the University of Washington Seattle. I am undecided on what I would like 
        to pursue as a major at this time, but I do have an interest in informatics."),
      h3("Maggie Wang"),
      img(src = "https://gfp-2a3tnpzj.stackpathdns.com/wp-content/uploads/2016/07/Dachshund-600x600.jpg",
          height = 200, width = 200, align = "middle"),
      h3("Kiley Wong"),
      img(src = "http://www.dogster.com/wp-content/uploads/2016/01/what-age-do-puppies-lose-their-teeth.jpg",
          height = 200, width = 200, align = "middle"),
      p("Hi hi! I am a shophomore at the University Washington Seattle. My intended major is either
        Informatics or Human Centered Design and Engineering. I am originally from Southern California
        and enjoy eating and exploring!")
    )
    ) 

))
