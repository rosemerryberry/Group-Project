#Rosemary Adams
#Last Edit: 02.25.2016
#Creating single choropleth map of 2010 education data
# install.packages("plotly")
require(plotly)
require(dplyr)

df <- read.csv("./data/complete_education_data.csv")

#give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

plot_ly(df, z = x2010, locations = code, type = 'choropleth', 
        locationmode = 'USA-states', color = x2010, colors = 'Purples',
        marker = list(line = l), colorbar = list(title = "Percent of College Attendance")) %>%
  layout(title = 'Percent of High School Graduates who Attend College (2010)', geo = g)


