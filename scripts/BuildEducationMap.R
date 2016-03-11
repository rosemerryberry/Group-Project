#Creates interactive choropleth map of education data

# install.packages("plotly")
#year options: even years between 1992 and 2010, parameter formatted as just the year

EducationMap <- function(year_input) {
  require(plotly)
  require(dplyr)

  educationData <- read.csv("./data/EducationData.csv")
  
  #format the parameter to work with the colnames of the data frame
  year <- paste0("x", year_input)
  
  #test condition
  #year <- "x2010"
  
  #hover text
  educationData$hover <- with(educationData, paste0(State, '<br>', 
                              "Percent College Attendance: ", educationData[,year]))

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
  plot_ly(educationData, z = educationData[,year], locations = code, text = hover, type = 'choropleth', 
          locationmode = 'USA-states', color = educationData[,year], colors = 'Purples',
          marker = list(line = l), colorbar = list(title = " % College Attendance")) %>%
    layout(title = 'Percent of High School Graduates who Attend College', geo = g)
}

