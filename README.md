# Project Proposal
_Allison Lee, Brian Luu, Tiffany Truong, Maggie Wang, Kiley Wong_

### Project Description
**What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.**

We will be working with a dataset called the Top Spotify Tracks of 2017, whose top three contributors are Cihan Oklap, Nadin Tamer, and Sang-eon Park. The dataset includes song ids, name of the songs, artists, audio features, and duration among other attributes. Data in this dataset are from the Spotify Web API and the data was retrieved from [kaggle.com](https://www.kaggle.com/nadintamer/top-tracks-of-2017/data).

**Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.**

Our targeted audience are those who listen to music frequently, at least once a day, and include both free or premium users. For this specific project, we want to target people who want to search for certain types of songs based on their audio features (danceability, energy, acousticness).

**What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.**

Our audience would want to learn:

- What tempo is most common in the featured top songs of 2017?
- Is there a common pattern between the danceability and loudness?
- Are higher speechiness (detects presence of spoken words in the track) more common in the top featured? If not, what is?

### Technical Description
**How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?**

We are using a static .csv file called _featuresdf.csv_ available through [kaggle.com](https://www.kaggle.com/nadintamer/top-tracks-of-2017/data)

**What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?**

After loading the featuresdf.csv file in Rstudio and viewing its attributes, we decided that we will not need to reformat the data since it is already a dataframe type. We will rely mostly on dplyr to help us wrangle the data. 

**What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)**

- stringr to wrangle data
- plotly for data visualizations
- ggplot2 for data visualizations
- shiny for publishing our project

**What major challenges do you anticipate?**

We anticipate challenges in wrangling our data to find and extract the information that is relevant to our project. Another challenge we will have is choosing how to present our data. Choosing types of charts or how we want to set the color and sizes and other details may be difficult.
