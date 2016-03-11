#builds interactive choropleth map of income data
#parameter year_input must be just the year, it is formatted in the function

IncomeMap <- function(year_input) {
  require(dplyr)
  require(plotly)
  require(RColorBrewer)

  #reads in the data
  income <- read.csv("./data/IncomeData.csv")
  
  #income only has state codes, so we need the state names for the hover text
  income$State <- c('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
                    'Connecticut', 'Delaware', 'District of Columbia', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
                    'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine',
                    'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi',
                    'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampsire', 'New Jersey',
                    'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma',
                    'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
                    'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
                    'West Virgina', 'Wisconsin', 'Wyoming')
  
  #formatting the year parameter to work with the colnames of the data frame
  year <- paste0("x", year_input)
  
  #hover text
  income$hover <- with(income, paste0(State, '<br>', "Income: $", income[,year]))
  
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
  plot_ly(income, z = income[,year], locations = code, text = hover, type = 'choropleth', 
          locationmode = 'USA-states', color = income[,year], colors = "Greens",
          colorbar = list(tickprefix = "$", title = "Income"), 
          marker = list(line = l)) %>%
    layout(title = 'Median Household Income', geo = g)
}
