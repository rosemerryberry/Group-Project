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
        
        # Build drop-down menu of all years the user can use
        #selectInput(
         # "crimeYear",
          #label = h3("Choose Year"),
          #choices = list(
           # "1992" = '1992',
            #"1994" = '1994',
            #"1996" = '1996',
            #"1998" = '1998',
            #"2000" = '2000',
            #"2002" = '2002',
            #"2004" = '2004',
            #"2008" = '2008',
            #"2010" = '2010',
            #"2012" = '2012'
          #),
          #selected = '1992'
        #),
        sliderInput("crimeYear", label = h3("Choose Year"), min = 1992, 
                    max = 2012, value = 2000, sep = "", step = 2),
        # sliderInput(
        #   "crimeYear",
        #   "Choose year",
        #   min = 1992,
        #   max = 2012,
        #   value = 1992,
        #   sep = "",
        #   step = 2
        # ),
        
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
               
               # Build drop-down for all the years the user can use
               selectInput(
                 "eduYear",
                 label = h3("Choose Year"),
                 choices = list(
                   "1992" = '1992',
                   "1994" = '1994',
                   "1996" = '1996',
                   "1998" = '1998',
                   "2000" = '2000',
                   "2002" = '2002',
                   "2004" = '2004',
                   "2008" = '2008',
                   "2010" = '2010',
                   "2012" = '2012'
                 ),
                 selected = '1992'
              )
             ),
             
             # render the education map
             mainPanel(plotlyOutput('eduMap'))
           )
        ),
  
  # incomse tab
  tabPanel('Income',
           titlePanel('Income Map'),
           # Create sidebar layout
           sidebarLayout(
             
             # Create a sidebar for controls
             sidebarPanel(
               
               # Build drop-down for all the years the user can use
               selectInput(
                 "incYear",
                 label = h3("Choose Year"),
                 choices = list(
                   "1992" = '1992',
                   "1994" = '1994',
                   "1996" = '1996',
                   "1998" = '1998',
                   "2000" = '2000',
                   "2002" = '2002',
                   "2004" = '2004',
                   "2008" = '2008',
                   "2010" = '2010',
                   "2012" = '2012'
                 ),
                 selected = '1992'
               )
             ),
             
             # render the education map
             mainPanel(plotlyOutput('incMap'))
           )
  )
)
)
