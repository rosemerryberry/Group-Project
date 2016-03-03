# require needed packages
library(shiny)
library(plotly)

# get needed data
crimeData <- read.csv('./data/CrimeData.csv')
educationData <- read.csv('./data/EducationData.csv')

# Begin Shiny UI
shinyUI(navbarPage(
  'Crime, Education, and Socio-Economic Data',
  
  # create tabs for different data sets
  
  # crime tab
  tabPanel(
    'Crime',
    titlePanel('Crime Map'),
    
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
           titlePanel('Education Map'),
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
           titlePanel('Income Map'),
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
