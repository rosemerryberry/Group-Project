# require needed packages
library(dplyr)
library(knitr)

# read in needed files
crimeData <- read.csv('data/CrimeData.csv')
incomeData <- read.csv('data/IncomeData.csv')
educationData <- read.csv('data/EducationData.csv')

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

# Display the report
kable(tableReport)

getTableValues <- function() {
   return (tableReport)
}