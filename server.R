# Require needed packages
library(plotly)
library(shiny)
library(dplyr)

# Get needed scripts and data
source('./scripts/BuildCrimeMap.R')
source('./scripts/BuildEducationMap.R')

crimeData <- read.csv('./data/CrimeData.csv')
educationData <- read.csv('./data/EducationData.csv')

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
})