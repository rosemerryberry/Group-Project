#Rosemary Adams
#Last Edit: 03.01.2016
#Creating single choropleth map of 2010 education data
<<<<<<< HEAD:scripts/BuildEducationMap.R
# install.packages("plotly")
require(plotly)
require(dplyr)

df <- read.csv("./data/complete_education_data.csv")
=======

#year options: even years between 1992 and 2010, formatted like "x2010" or "x1996"
>>>>>>> 41ca8dcde4e6101926d2ba7cfc4c641cdba3eafb:education_map.R

build_education_map <- function(year) {
  require(plotly)
  require(dplyr)

  df <- read.csv("./complete_education_data.csv")

  #give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  plot_ly(df, z = year, locations = code, type = 'choropleth', 
          locationmode = 'USA-states', color = year, colors = 'Purples',
          marker = list(line = l), colorbar = list(title = "Percent of College Attendance")) %>%
    layout(title = 'Percent of High School Graduates who Attend College', geo = g)
}

