##linear plot
#rosemary adams

#years represents the input from a double slide bar. Here is the code for the UI:

#sliderInput("linearPlot", label = h3("Slider Range"), min = 1992, 
#            max = 2010, value = c(1996, 2006), sep = "", step = 2)

#Here is the code for the server:

#output$linearPlot <- renderPlotly({
#   construct_linear(input$linearPlot)
#})

construct_linear <- function(years) {
  require(dplyr)
  require(plotly)
  crime <- read.csv("./data/normalCrime.csv")
  edu <- read.csv("./data/normalEdu.csv")
  income <- read.csv("./data/normalIncome.csv")
  
  #test values
  #years <- c(1998, 2006)
  
  crime <- filter(crime, Year >= years[1],Year <= years[2])
  edu <- filter(edu, Year >= years[1],Year <= years[2])
  income <- filter(income, Year >= years[1],Year <= years[2])
  
  normalEdu <- edu$normalEdu
  normalIncome <- income$normalIncome
  "Normalized Data" <- crime$normalCrime

  p <- plot_ly(crime, x = Year, y = `Normalized Data`, name = "Violent Crime") %>%
       add_trace(y = normalEdu, name = "Education") %>%
       add_trace(y = normalIncome, name = "Income")
     
}
