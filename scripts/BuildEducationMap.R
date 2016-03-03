#Rosemary Adams
#Last Edit: 03.01.2016
#Creating single choropleth map of 2010 education data
# install.packages("plotly")
require(plotly)
require(dplyr)

df <- read.csv("./data/EducationData.csv")

#year options: even years between 1992 and 2010, parameter formatted as just the year

EducationMap <- function(year_input) {
  require(plotly)
  require(dplyr)

  df <- read.csv("./data/EducationData.csv")
  
  year <- paste0("x", year_input)
  
  #test condition
  #year <- "x2010"

  #give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  plot_ly(df, z = df[,year], locations = code, type = 'choropleth', 
          locationmode = 'USA-states', color = df[,year], colors = 'Purples',
          marker = list(line = l), colorbar = list(title = " % College Attendance")) %>%
    layout(title = 'Percent of High School Graduates who Attend College', geo = g)
}

