#Deep Data Histogram
require(dplyr)
require(plotly)
require(RColorBrewer)

BuildHistogram <- function(data_type, year, stateOne, stateTwo, stateThree){

edf <- read.csv("./data/EducationData.csv")
cdf <- read.csv("./data/CrimeData.csv")
idf <- read.csv("./data/IncomeRebuild.csv")

#For Changing to xDATE format to match the columns in the dataframes
yearChoiceX <- paste0("x", year)

#Conditionals based on what dataset is read in.
#Returns df of dataset, year, and 3 states requested
  
  #If User chooses to view Income

if (data_type == "Income") {
  df <- filter(idf, code == stateOne| code == stateTwo| code == stateThree ) %>%
    select(eval(parse(text=yearChoiceX)), code)
  dataname <- "Median Income"
  colorChoice <- "darkgreen"

  #If User choosesto view Education

} else if (data_type == "Education") {
  df <- filter(edf, code == stateOne| code == stateTwo | code == stateThree) %>%
    select(eval(parse(text=yearChoiceX)), code)
  dataname <- "Education Score"
  colorChoice <- "darkblue"

  #If user chooses to view Crime  
  
} else if (data_type == "Crime") {
  df <- filter(cdf, Code == stateOne| Code == stateTwo| Code == stateThree) %>%
    filter(Year == eval(parse(text=year))) %>%
    select(Violent.Crime.rate, Code)
  #Reformat df to standard format. Original Crime dataframe format requires this
  colnames(df) <- c(yearChoiceX, "code")
  dataname <- "Violent Crime Rate"
  colorChoice <- "darkred"
  
}

#Build Bar Chart of new, specific df
plot_ly(df, y = eval(parse(text=yearChoiceX)), x = code, type = "bar", marker = list(color = toRGB(colorChoice))) %>%
  layout(yaxis = list(title = paste(dataname)), xaxis = list(title = "States")) %>%
  return()

}

