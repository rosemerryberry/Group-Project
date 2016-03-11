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
  df <- filter(idf, code == stateOne | code == stateTwo| code == stateThree ) %>%
    select(yearChoiceX)

} else if (data_type == "Education") {
  df <- filter(edf, code = stateOne| code == stateTwo | code == stateThree) %>%
    select(yearChoiceX)

} else if (data_type == "Crime") {
  df <- filter(cdf, Code == stateOne| Code == stateTwo| Code == stateThree, year) %>%
    select(Violent.Crime.rate)
  colnames(df) <- yearChoiceX
} else {
   return ('This is not a Supported Data Type');
}

#Ploting Bar Chart
plot_ly(df, y = eval(parse(text=yearChoiceX)), type = "bar")
###########TEST######


######################
}

