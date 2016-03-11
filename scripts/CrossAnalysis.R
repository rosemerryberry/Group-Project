# Cross Analysis is a program that runs linear analysis between two of three data sets for a state or America as a whole.
# It takes a state code and two data sets and returns a graphic with informaiton as to the relationship between the 
# two data sets

CrossAnalysis <- function(stateChoice, dataChoice1, dataChoice2){
  library(plotly)
  library(dplyr)
  # State choice should be in code form but can inclued TOT for total. 
  
  # Get all years we will be doing the time analysis for. 
  years <- c("1992", "1994", "1996", "1998", "2000", "2002", "2004", "2006", "2008", "2010")
  yearsnum <- c(1992, 1994, 1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010)
  
  # Set general size
  DotSize <- 10
  # Aquire the appropriate data
  returnSet <- c()
  if (stateChoice == "TOT"){
    
    #Using this one boolean this logic tree assigns data sets and axis names to general terms that can be manipulated later
    gotIt <- FALSE
    if (dataChoice1 == "Crime" | dataChoice2 == "Crime") {
      
      data1 <- read.csv("./data/normalCrime.csv") %>% select(Year, mean)
      yaxe <- "Violent Crime Rate"
      gotIt <- TRUE
      
    }
    
    if (dataChoice1 == "Education" | dataChoice2 == "Education") {
      
      if (gotIt){
        # In the possible end branches the data is also fit
        data2 <- read.csv("./data/normalEdu.csv") %>% select(Year, mean)
        AnalysisFit <- lm(data1[,2] ~ data2[,2])
        xaxe <- "Education Score"
        
      } else {
                
        data1 <- read.csv("./data/normalEdu.csv") %>% select(Year, mean)
        yaxe <- "Education Score"
        
      }
    
    }
    
    if (dataChoice1 == "Income" | dataChoice2 == "Income") {
      
      # In the possible end branches the data is also fit
      data2 <- read.csv("./data/normalIncome.csv") %>% select(Year, mean)
      AnalysisFit <- lm(data1[,2] ~ data2[,2])
      xaxe <- "Median Income" 
    }
    
    # Build names for the legend that include the slope so that the user can see the actual number on the graph
    FitName <- paste("Fit: m =", round(AnalysisFit$coefficients[2], digits = 4))
    DatName <- paste(dataChoice1, "vs", dataChoice2)
    
    # Now we build a plot using the generic data and names and apply the fit. 
    plot_ly(x = data2[,2], y = data1[,2], mode = "markers", name = DatName, marker = list(color = "red", size = DotSize)) %>% layout(xaxis = list(title = xaxe), yaxis = list(title = yaxe)) %>% add_trace(y = fitted(AnalysisFit), mode = "line", name = FitName, line = list(color = "black"), marker = list(color = "black")) %>% return()

  } else {
    
    #Using this one boolean this logic tree assigns data sets and axis names to general terms that can be manipulated later
    gotIt <- FALSE
    if (dataChoice1 == "Crime" | dataChoice2 == "Crime") {
      
      data1 <- read.csv("./data/CrimeData.csv") %>% filter(State != "Total", Year %in% years, Code == stateChoice) %>% select(Year, Violent.Crime.rate)
      data1 <- data1[,2]
      yaxe <- "Violent Crime Rate"
      gotIt <- TRUE
      
    }
    
    if (dataChoice1 == "Education" | dataChoice2 == "Education") {
      
      if (gotIt){
        # In the possible end branches the data is also fit
        data2 <- read.csv("./data/EducationData.csv") %>% filter(code == stateChoice) %>% select(-State, -x2012, -X)
        data2 <- unlist(data2[1,1:length(data2[1,]) - 1])
        AnalysisFit <- lm(data1 ~ data2)
        xaxe <- "Education Score"
        
      } else {
        
        data1 <- read.csv("./data/EducationData.csv") %>% filter(code == stateChoice) %>% select(-State, -x2012, -X)
        data1 <- unlist(data1[1,1:length(data1[1,]) - 1])
        yaxe <- "Education Score"
        
      }
      
    }
    
    if (dataChoice1 == "Income" | dataChoice2 == "Income") {
      
      # In the possible end branches the data is also fit
      data2 <- read.csv("./data/IncomeRebuild.csv") %>% filter(code == stateChoice) %>% select(-x2012, -X)
      data2 <- rev(unlist(data2[1,2:length(data2[1,])]))
      AnalysisFit <- lm(data1 ~ data2)
      xaxe <- "Median Income"
      
    }
    
    # Build names for the legend that include the slope so that the user can see the actual number on the graph
    FitName <- paste("Fit: m =", round(AnalysisFit$coefficients[2], digits = 4))
    DatName <- paste(dataChoice1, "vs", dataChoice2)
    
    # Now we build a plot using the generic data and names and apply the fit. 
    plot_ly(x = data2, y = data1, mode = "markers", name = DatName, marker = list(color = "red", size = DotSize)) %>% layout(xaxis = list(title = xaxe), yaxis = list(title = yaxe)) %>% add_trace(y = fitted(AnalysisFit), mode = "line", name = FitName, line = list(color = "black"), marker = list(color = "black")) %>% return()
    
    
  }  
    

}