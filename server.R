# Require needed packages
library(plotly)
library(shiny)
library(dplyr)

# import needed scripts
source('./scripts/BuildCrimeMap.R')
source('./scripts/BuildEducationMap.R')
source('./scripts/BuildIncomeMap.R')

# Begin Shiny Server
shinyServer(function(input, output) {
   
  # Output the crime data
  output$crimeMap <- renderPlotly({ 
    CrimeMap(input$crimeType, input$crimeYear)  
  })
  
  # Output the education data
  output$eduMap <- renderPlotly({
    EducationMap(input$eduYear)
  })
  
  # Output the income data
  output$incMap <- renderPlotly({
    IncomeMap(input$incYear)
  })
})