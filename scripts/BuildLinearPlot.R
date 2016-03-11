#constructs a normal linear plot of the three data sets
#the user can choose the range of years for the x-axis
#the normalization does not adjust based on the years
construct_linear <- function(years) {
  require(dplyr)
  require(plotly)
  crime <- read.csv("./data/normalCrime.csv")
  edu <- read.csv("./data/normalEdu.csv")
  income <- read.csv("./data/normalIncome.csv")
  
  #test values
  #years <- c(1998, 2006)
  
  #filters the data sets based on the user's year choices
  crime <- filter(crime, Year >= years[1],Year <= years[2])
  edu <- filter(edu, Year >= years[1],Year <= years[2])
  income <- filter(income, Year >= years[1],Year <= years[2])
  
  #normal data is used to show everything on the same scale
  normalEdu <- edu$normalEdu %>% round(digits = 2)
  normalIncome <- income$normalIncome %>% round(digits = 2)
  "Normalized Data" <- crime$normalCrime %>% round(digits = 2)
  
  #build the plot
  p <- plot_ly(crime, x = Year, y = `Normalized Data`, name = "Violent Crime", 
               line = list(color = "red")) %>%
       add_trace(y = normalEdu, name = "Education", line = list(color = "purple")) %>%
       add_trace(y = normalIncome, name = "Income", line = list(color = "green"))
   
  return(p)
}
