##linear plot
#rosemary adams


construct_linear <- function(data) {
  
  require(dplyr)
  
  crime <- read.csv("./data/CrimeData.csv")

  edu <- read.csv("./data/EducationData.csv")

  income <- read.csv("./data/IncomeRebuild.csv")

  years <- c(1992, 1994, 1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010)

  crime_formatted <- crime %>% 
                     select(Year, Violent.Crime.rate) %>%
                     group_by(Year) %>% 
                     summarise(mean = mean(Violent.Crime.rate)) %>%
                     filter(Year >= 1992, Year <= 2010, Year %% 2 == 0)

  edu_data <- edu[51, 3:12]
  edu2 <- as.numeric(as.vector(edu_data[1,]))

  income1 <- c(mean(income$x2010), mean(income$x2012))

  p <- plot_ly(crime_formatted, x = Year, y = mean, name = "Average Violent Crime Rates in the US")
       p %>% add_trace(y = edu2)
     
}