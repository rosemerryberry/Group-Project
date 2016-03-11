# Time Analysis is a function that takes in a state of choice and interrogates our crime, income, and 
# education data sets in order to build a linear regression statistical test for each topic. It returns
# the statistical information related to these tests and graphs that represent them. 

TimeAnalysis <- function(stateChoice, dataChoice){
  library(plotly)
  library(dplyr)
  # State choice should be in code form but can inclued TOT for total. 
  
  # Get all years we will be doing the time analysis for. 
  years <- c("1992", "1994", "1996", "1998", "2000", "2002", "2004", "2006", "2008", "2010")
  yearsnum <- c(1992, 1994, 1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010)
  # Aquire the appropriate data
  returnSet <- c()
  if (stateChoice == "TOT"){
    
    crimeData <- read.csv("./data/normalCrime.csv") %>% select(Year, mean)
    educationData <- read.csv("./data/normalEdu.csv") %>% select(Year, mean)
    incomeData <- read.csv("./data/normalIncome.csv") %>% select(Year, mean)
    
    # Now we fit the data using the statistics inherent to R
    crimefit <- lm(crimeData[,2] ~ crimeData[,1])
    edufit <- lm(educationData[,2] ~ educationData[,1])
    incomefit <- lm(incomeData[,2] ~ incomeData[,1])
    
    crimeName <- paste("Fit: m =", round(crimefit$coefficients[2]), digits = 2)
    eduName <- paste("Fit: m =", round(edufit$coefficients[2]), digits = 2)
    incomeName <- paste("Fit: m =", round(incomefit$coefficients[2]), digits = 2)
    
    returnSet$crimeGraphic <- plot_ly(x = crimeData[,1], y = crimeData[,2], mode = "markers", name = "Crime Data", marker = list(color = "red")) %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Violent Crime Rate")) %>% add_trace(y = fitted(crimefit), mode = "line", name = crimeName, line = list(color = "black"), marker = list(color = "black"))
    returnSet$eduGraphic <- plot_ly(x = educationData[,1], y = educationData[,2], mode = "markers", name = "Education Data") %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Education Score")) %>% add_trace(y = fitted(edufit), mode = "line", name = eduName, line = list(color = "black"), marker = list(color = "black"))
    returnSet$incomeGraphic <- plot_ly(x = incomeData[,1], y = incomeData[,2], mode = "markers", name = "Income Data", marker = list(color = "green")) %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Median Income")) %>% add_trace(y = fitted(incomefit), mode = "line", name = incomeName, line = list(color = "black"), marker = list(color = "black"))
    
  } else {
  
    crimeData <- read.csv("./data/CrimeData.csv") %>% filter(State != "Total", Year %in% years, Code == stateChoice) %>% select(Year, Violent.Crime.rate)
    educationData <- read.csv("./data/EducationData.csv") %>% filter(code == stateChoice) %>% select(-State, -x2012, -X)
    incomeData <- read.csv("./data/IncomeRebuild.csv") %>% filter(code == stateChoice) %>% select(-x2012, -X)
    
    crimefit <- lm(crimeData[,2] ~ crimeData[,1])
    edudat <- unlist(educationData[1,1:length(incomeData[1,]) - 1])
    edufit <- lm(edudat ~ yearsnum)
    incomedat <- rev(unlist(incomeData[1,2:length(incomeData[1,])]))
    incomefit <- lm(incomedat ~ yearsnum)
    
    crimeName <- paste("Fit: m =", round(crimefit$coefficients[2]), digits = 2)
    eduName <- paste("Fit: m =", round(edufit$coefficients[2]), digits = 2)
    incomeName <- paste("Fit: m =", round(incomefit$coefficients[2]), digits = 2)
    
    returnSet$crimeGraphic <- plot_ly(x = yearsnum, y = crimeData[,2], mode = "markers", name = "Crime Data", marker = list(color = "red")) %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Violent Crime Rate")) %>% add_trace(y = fitted(crimefit), mode = "line", name = crimeName, line = list(color = "black"), marker = list(color = "black"))
    returnSet$eduGraphic <- plot_ly(x = yearsnum, y = edudat, mode = "markers", name = "Education Data") %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Education Score")) %>% add_trace(y = fitted(edufit), mode = "line", name = eduName, line = list(color = "black"), marker = list(color = "black"))
    returnSet$incomeGraphic <- plot_ly(x = yearsnum, y = incomedat, mode = "markers", name = "Income Data", marker = list(color = "green")) %>% layout(xaxis = list(title = "Year"), yaxis = list(title = "Median Income")) %>% add_trace(y = fitted(incomefit), mode = "line", name = incomeName, line = list(color = "black"), marker = list(color = "black"))
  }  
    
    if (dataChoice == "Crime"){
      
      return(returnSet$crimeGraphic)
      
    } else if (dataChoice == "Education") {
      
      return(returnSet$eduGraphic)
      
    } else {
      
      return(returnSet$incomeGraphic)
      
    }
    
    #returnSet$crimeCoeff <- crimefit$coefficients
    #returnSet$crimeP <- summary(crimefit)$coefficients[2,4]
    #returnSet$eduCoeff <- edufit$coefficients
    #returnSet$eduP <- summary(edufit)$coefficients[2,4]
    #returnSet$incomeCoeff <- incomefit$coefficients
    #returnSet$incomeP <- summary(incomefit)$coefficients[2,4]

}