# Server script. Will control the outputing of the various elements found in the report.

# Require needed packages
library(plotly)
library(shiny)
library(dplyr)
library(knitr)

# import needed scripts
source('./scripts/BuildCrimeMap.R')
source('./scripts/BuildEducationMap.R')
source('./scripts/BuildIncomeMap.R')
source('./scripts/BuildLinearPlot.R')
source('./scripts/BuildSummaryTable.R')
source('./scripts/BuildHistogram.R')
source('./scripts/PredictEducation.R')
source('./scripts/TimeAnalysis.R')

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
  
  # output the NormLinPlot data
  output$linPlot <- renderPlotly({
    construct_linear(input$linearPlot)
  })
  
  # output machine learning data
  output$PredictEdu <- renderPlot({
     PredictEducation()
  })
  
  # output the time analysis data
  output$timeAnalysis <- renderPlotly({
     TimeAnalysis(input$timeStateChoice, input$timeDataChoice)
  })
  
  # Output the summary table
  output$sumTable <- renderTable({
     buildSummary()
  })
  
  # Output the Histogram
  output$histogram <- renderPlotly({
     BuildHistogram(input$histDataType, input$histYear, 
                    input$histStateOne, input$histStateTwo, 
                    input$histStateThree)
  })
})