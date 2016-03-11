#Deep Data Histogram
#wishmeluck
require(dplyr)
require(plotly)
require(RColorBrewer)

BuildHistogram <- function(data_type, year, stateOne, stateTwo, stateThree){

edf <- read.csv("./data/EducationData.csv")
cdf <- read.csv("./data/CrimeData.csv")
idf <- read.csv("./data/IncomeRebuild.csv")

#For Changing to xDATE format
yearChoiceX <- paste0("x", year)

#Conditionals for the dataset read in.

if (data_type == "Income") {
  df <- filter(idf, code == stateOne| code == stateTwo| code == stateThree ) %>%
    select(eval(parse(text=yearChoiceX)), code)
  dataname <- "Median Income"
  colorChoice <- "darkgreen"

} else if (data_type == "Education") {
  df <- filter(edf, code == stateOne| code == stateTwo | code == stateThree) %>%
    select(eval(parse(text=yearChoiceX)), code)
  dataname <- "Education Score"
  colorChoice <- "darkblue"

} else if (data_type == "Crime") {
  df <- filter(cdf, Code == stateOne| Code == stateTwo| Code == stateThree) %>%
    filter(Year == eval(parse(text=year))) %>%
    select(Violent.Crime.rate, Code)
  colnames(df) <- c(yearChoiceX, "code")
  dataname <- "Violent Crime Rate"
  colorChoice <- "darkred"
  
}

#Ploting Bar Chart
plot_ly(df, y = eval(parse(text=yearChoiceX)), x = code, type = "bar", marker = list(color = toRGB(colorChoice))) %>%
  layout(yaxis = list(title = paste(dataname)), xaxis = list(title = "States")) %>%
  return()

}

