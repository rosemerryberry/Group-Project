#Rosemary 
#03.02.2015
#Income data plot formula

#parameter year needs to be formatted like "X2010" or "X1992"

IncomeMap <- function(year) {
  require(dplyr)
  require(plotly)
  #reads in the data
  income <- read.csv("./data/IncomeData.csv")
  #every time I do this it adds a column at the front of row numbers so I take that out
  income <- income[, 2:13]
  
  #give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  plot_ly(income, z = year, locations = code, type = 'choropleth', 
          locationmode = 'USA-states', color = year, colors = "Greens",
          colorbar = list(tickprefix = "$", title = "Average Household Income"), 
          marker = list(line = l)) %>%
    layout(title = 'Average Household Income', geo = g)
}
