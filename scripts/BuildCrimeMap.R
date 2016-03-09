# Crime Map takes in a choice year and a specific crime and makes a choropleth map of the united states
# with the color red representing the intensity of the crime in question per state. 

CrimeMap <- function(crime, choiceYear){
  library(plotly)
  library(dplyr)
  # I need the input to be converted to the appropriate rate
  # These two lines are test inputs to override user input.
  #choiceYear = "2012"
  #crime <- "Motor.vehicle.theft"
  crime <- paste0(crime, ".rate")
  
  # Load some of that data and cut out the crap
  crimeData <- read.csv("./data/CrimeData.csv") %>% filter(Year == choiceYear, State != "Total")
  
  # Find the column number my data lives at and give it a name I can grab at later. 
  Locate <- match(crime, colnames(crimeData))
  crimeData$Choice <- crimeData[,Locate]
  
  # Build some hover data that changes in response to the crime input. 
  crimeData$hover <- with(crimeData, paste0(State, '<br>', "Population: ", Population, '<br>', crime,": ", Choice))
  
  
  # Get the colors in order, more negative ones so that out of the three graphs the user 
  # will instinctively associate this one with crime as opposed to income or economy.
  
  borders <- list(color = toRGB("black"), width = 2)
  gradientColor <- "Purples"
  
  #give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  
  # Simple American Geography options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB("white")
  )
  
  # Now lets build this
  plot_ly(crimeData, z = crimeData[,Locate], text = hover, locations = Code, type = "choropleth", 
          locationmode = 'USA-states', color = crimeData[,Locate], colors = "Reds", 
          marker = list(line = l), colorbar = list(title = "Per Capita")) %>% 
    layout(title = "United State Department of Justice Crime Data", geo = g) %>% 
    return()
}