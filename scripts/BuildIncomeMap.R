#Rosemary 
#03.02.2015
#Income data plot formula

#parameter year must be just the year, it is formatted in the function

IncomeMap <- function(year_input) {
  require(dplyr)
  require(plotly)
  #reads in the data
  income <- read.csv("./data/IncomeData.csv")
  #every time I do this it adds a column at the front of row numbers so I take that out
  income <- income[, 2:13]
  
  year <- paste0("X", year_input)
  
  #test value
  year <- "X2010"
  
  #give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  plot_ly(income, z = income[,year], locations = code, type = 'choropleth', 
          locationmode = 'USA-states', color = income[,year], colors = "Greens",
          colorbar = list(tickprefix = "$", title = "Average Household Income"), 
          marker = list(line = l)) %>%
    layout(title = 'Average Household Income', geo = g)
  
  plot_ly(income, z = income[,year], locations = code, type = 'choropleth', locationmode = "USA-states") %>%
    layout(geo = g)
}
