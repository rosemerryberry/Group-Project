#Lets build a summary table!
buildSummary <- function(){

  # require needed packages
  library(dplyr)
  library(knitr)

  # read in needed files
  crimeData <- read.csv('./data/CrimeData.csv')
  incomeData <- read.csv('./data/IncomeData.csv')
  educationData <- read.csv('./data/EducationData.csv')
  
  # Filter down crimeData to only contain years that
  # the report works with (1992 - 2010 even)
  crimeData <- filter(crimeData, Year >= 1992) %>% 
     filter(Year <= 2010) %>% 
     filter(Year %% 2 != 1)
  
  # Construct new DF to store values to report in the table.
  # Build a year column to compare key facts against
  tableReport <- select(crimeData, Year) %>% 
     distinct() %>% 
     filter(Year >= 1992) %>% 
     filter(Year <= 2010) %>% 
     filter(Year %% 2 != 1)
  
  #lets get the max/min crime state
  #DC is excluded because it is not represented in all three datasets
  crimeMax <- crimeData %>% filter(Code != "DC") %>%
              select(State, Year, Violent.Crime.rate) %>%
              group_by(Year) %>%
              filter(Violent.Crime.rate == max(Violent.Crime.rate))
  
  crimeMin <- crimeData %>% filter(Code != "DC") %>%
              select(State, Year, Violent.Crime.rate) %>%
              group_by(Year) %>%
              filter(Violent.Crime.rate == min(Violent.Crime.rate))
  
  tableReport$CrimeMax <- crimeMax$State
  tableReport$CrimeMin <- crimeMin$State
  
  #lets get education max and min. 
  #Iman said we could do this btw
  #basically the data frame was being weird, so each of these statements return the state
  #but when mashed in a list or vector they return numbers, so this is the solution
  education1 <- educationData %>% filter(x1992 == max(x1992)) %>% select(State)#newyork
  education2 <- educationData %>% filter(x1994 == max(x1994)) %>% select(State)#newyork
  education3 <- educationData %>% filter(x1996 == max(x1996)) %>% select(State)#newyork
  education4 <- educationData %>% filter(x1998 == max(x1998)) %>% select(State)#massachusetts
  education5 <- educationData %>% filter(x2000 == max(x2000)) %>% select(State)#ndakota
  education6 <- educationData %>% filter(x2002 == max(x2002)) %>% select(State)#ndakota
  education7 <- educationData %>% filter(x2004 == max(x2004)) %>% select(State)#sdakota
  education8 <- educationData %>% filter(x2006 == max(x2006)) %>% select(State)#mississippi
  education9 <- educationData %>% filter(x2008 == max(x2008)) %>% select(State)#mississippi
  education10 <- educationData %>% filter(x2010 == max(x2010)) %>% select(State)#mississippi
  
  educationMax <- c("New York", "New York", "New York", "Massachusetts", "North Dakota",
                    "North Dakota", "South Dakota", "Mississippi", "Mississippi", "Mississippi")
  
  tableReport$EducationMax <- educationMax
  
  educationMin1 <- educationData %>% filter(x1992 == min(x1992)) %>% select(State)#Nevada
  educationMin2 <- educationData %>% filter(x1994 == min(x1994)) %>% select(State)#Alaska
  educationMin3 <- educationData %>% filter(x1996 == min(x1996)) %>% select(State)#Nevada
  educationMin4 <- educationData %>% filter(x1998 == min(x1998)) %>% select(State)#Nevada
  educationMin5 <- educationData %>% filter(x2000 == min(x2000)) %>% select(State)#Utah
  educationMin6 <- educationData %>% filter(x2002 == min(x2002)) %>% select(State)#Nevada
  educationMin7 <- educationData %>% filter(x2004 == min(x2004)) %>% select(State)#Vermont
  educationMin8 <- educationData %>% filter(x2006 == min(x2006)) %>% select(State)#Arizona
  educationMin9 <- educationData %>% filter(x2008 == min(x2008)) %>% select(State)#Alaska
  educationMin10 <- educationData %>% filter(x2010 == min(x2010)) %>% select(State)#Idaho
  
  educationMin <- c("Nevada", "Alaska", "Nevada", "Nevada", "Utah", "Nevada", "Vermont",
                    "Arizona", "Alaska", "Idaho")
  
  tableReport$EducationMin <- educationMin
  
  #Here we go again, here we go again
  in1 <- incomeData %>% filter(x1992 == max(x1992)) %>% select(code)#Hawaii
  in2 <- incomeData %>% filter(x1994 == max(x1994)) %>% select(code)#Alaska
  in3 <- incomeData %>% filter(x1996 == max(x1996)) %>% select(code)#Alaska
  in4 <- incomeData %>% filter(x1998 == max(x1998)) %>% select(code)#Alaska
  in5 <- incomeData %>% filter(x2000 == max(x2000)) %>% select(code)#Maryland
  in6 <- incomeData %>% filter(x2002 == max(x2002)) %>% select(code)#Maryland
  in7 <- incomeData %>% filter(x2004 == max(x2004)) %>% select(code)#Maryland
  in8 <- incomeData %>% filter(x2006 == max(x2006)) %>% select(code)#New Jersey
  in9 <- incomeData %>% filter(x2008 == max(x2008)) %>% select(code)#New Hampshire
  in10 <- incomeData %>% filter(x2010 == max(x2010)) %>% select(code)#New Hampshire
  
  incomeMax <- c("Hawaii", "Alaska", "Alaska", "Alaska", "Maryland", "Maryland", "Maryland",
                 "New Jersey", "New Hampshire", "New Hampshire")
  
  tableReport$IncomeMax <- incomeMax
  
  inmin1 <- incomeData %>% filter(x1992 == min(x1992)) %>% select(code)#wv
  inmin2 <- incomeData %>% filter(x1994 == min(x1994)) %>% select(code)#wv
  inmin3 <- incomeData %>% filter(x1996 == min(x1996)) %>% select(code)#nm
  inmin4 <- incomeData %>% filter(x1998 == min(x1998)) %>% select(code)#wv
  inmin5 <- incomeData %>% filter(x2000 == min(x2000)) %>% select(code)#wv
  inmin6 <- incomeData %>% filter(x2002 == min(x2002)) %>% select(code)#wv
  inmin7 <- incomeData %>% filter(x2004 == min(x2004)) %>% select(code)#wv
  inmin8 <- incomeData %>% filter(x2006 == min(x2006)) %>% select(code)#ms
  inmin9 <- incomeData %>% filter(x2008 == min(x2008)) %>% select(code)#ms
  inmin10 <- incomeData %>% filter(x2010 == min(x2010)) %>% select(code)#ms
  
  incomeMin<- c("West Virginia", "West Virginia", "New Mexico", "West Virginia", "West Virginia", 
                 "West Virginia", "West Virginia", "Mississippi", "Mississippi", "Mississippi")
  
  tableReport$IncomeMin <- incomeMin
  
  return(tableReport)
}
