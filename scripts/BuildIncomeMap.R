#builds interactive choropleth map of income data
#parameter year_input must be just the year, it is formatted in the function

IncomeMap <- function(year_input) {
  require(dplyr)
  require(plotly)
  require(RColorBrewer)

  #reads in the data
  income <- read.csv("./data/IncomeData.csv")
  
  year <- paste0("x", year_input)
  
  #test value
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
  
  #builds map
  plot_ly(income, z = income[,year], locations = code, type = 'choropleth', 
          locationmode = 'USA-states', color = income[,year], colors = "Greens",
          colorbar = list(tickprefix = "$", title = "Income"), 
          marker = list(line = l)) %>%
    layout(title = 'Median Household Income', geo = g)
}
