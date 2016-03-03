# require needed packages
library(shiny)
library(plotly)

# get needed data
crimeData <- read.csv('./data/CrimeData.csv')
educationData <- read.csv('./data/EducationData.csv')

# Begin Shiny UI
shinyUI(navbarPage(theme = 'bootstrap.css',
  
  # style the UI with the styler sheet
  includeCSS('www/styler.css'),
  
  'Crime, Education, and Socio-Economic Data',
  
  # create tabs for different data sets
  
  # crime tab
  tabPanel(
    'Crime',
    
    # give intro to user
    tags$p(
      tags$div(
        id = 'CrimeMapIntroBox',
        tags$div(
          id = 'GlobalMapIntro',
          "This is a Crime Map description placeholder! This is now just some random text to the
          automatic box sizing. It looks like it is working as intended."
        )
      )
    ),
    
    titlePanel(tags$div(id = "CrimeMapHeader",
                        checked = NA,
                        'Crime Map')),
    
    # Create a sidebar for controls
    sidebarLayout(
      sidebarPanel(
        
        # build slider to control year
        sliderInput("crimeYear", label = h3("Choose Year"), min = 1992, 
                    max = 2010, value = 2000, sep = "", step = 2),
        
        # build input for crime type
        selectInput(
          'crimeType', label = h3("Choose Crime Type"), 
          choices = list(
            'Rape' = 'Forcible.rape',
            'Robbery' = 'Robbery',
            'Aggravated Assault' = 'Aggravated.assault',
            'Burglary' = 'Burglary',
            'Larceny Theft' = 'Larceny.theft',
            'Motor Vehicle Theft' = 'Motor.vehicle.theft'
          )
        )
   ),
      # Render the crime map
      mainPanel(plotlyOutput('crimeMap')))
   ),

  
  # education tab
  tabPanel('Education',
           
           # give intro to user
           tags$p(
             tags$div(
               id = 'EducationMapIntroBox',
               tags$div(
                 id = 'GlobalMapIntro',
                 "This is an Education Map description placeholder! This is now just some random text to the
                  automatic box sizing. It looks like it is working as intended."
               )
              )
            ),
           
           titlePanel(tags$div(id = "EducationMapHeader", 
                                 'Education Map')),
           
           # Create sidebar layout
           sidebarLayout(
             
             # Create a sidebar for controls
             sidebarPanel(
               
               # build slider to control year
                sliderInput("eduYear", label = h3("Choose Year"), min = 1992, 
                            max = 2010, value = 2000, sep = "", step = 2)
              ),
             
             # render the education map
             mainPanel(plotlyOutput('eduMap')))
           ),
  
  # incomse tab
  tabPanel('Income',
           
           # give intro to user
           tags$p(
             tags$div(
               id = 'IncomeMapIntroBox',
               tags$div(
                 id = 'GlobalMapIntro',
                 "This is an Income Map description placeholder! This is now just some random text to the
                  automatic box sizing. It looks like it is working as intended."
               )
              )
            ),
           
           titlePanel(tags$div(id = "IncomeMapHeader",
                                 'Income Map')),
           
           # Create sidebar layout
           sidebarLayout(
             
             # Create a sidebar for controls
             sidebarPanel(
               
               # Build slider to control year
                sliderInput("incYear", label = h3("Choose Year"), min = 1992, 
                            max = 2010, value = 2000, sep = "", step = 2)
             ),
             
             # render the education map
             mainPanel(plotlyOutput('incMap')))
         )
      )
   )
