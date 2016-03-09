# require needed packages
library(shiny)
library(plotly)

# Begin Shiny UI
shinyUI(navbarPage(
   
   # import styler.css for formatting
   tags$head(
      tags$title('Quality of Life Analysis Report'),
      tags$link(rel = 'stylesheet', type = 'text/css', href = 'styler.css')
   ),
   
   # load the theme for the report
   theme = 'bootstrap.css',
   
   # create tabs for different data sets
   
   # HOME TAB ==============================================================================================================
   tabPanel(
      # home page tab that reads in data from html/index.html
      titlePanel(
         tags$div(id = 'GlobalNavTab', 'Home'),
         windowTitle = 'Home'
      ),
      includeHTML('html/index.html')
   ),
   
   # CRIME MAP TAB =========================================================================================================
   tabPanel(
      titlePanel(
         tags$div(
            id = 'GlobalNavTab',
            'Crime'
         )
      ),
      
      # give intro to user
      tags$p(
         tags$div(
            id = 'CrimeMapIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/crimeMapDesc.html')
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
            sliderInput("crimeYear", label = h3("Year"), min = 1992, 
                        max = 2010, value = 2000, sep = "", step = 2),
            
            # build input for crime type
            selectInput(
               'crimeType', label = h3("Crime Type"), 
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
   
   
   # EDUCATION TAB ===========================================================================================================
   tabPanel(
      titlePanel(
         tags$div(
            id = 'GlobalNavTab',
            'Education'
         )
      ),
      
      # give intro to user
      tags$p(
         tags$div(
            id = 'EducationMapIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/educationMapDesc.html')
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
            sliderInput("eduYear", label = h3("Year"), min = 1992, 
                        max = 2010, value = 2000, sep = "", step = 2)
         ),
         
         # render the education map
         mainPanel(plotlyOutput('eduMap')))
   ),
   
   # INCOME TAB ==============================================================================================================
   tabPanel(
      titlePanel(
         tags$div(
            id = 'GlobalNavTab',
            'Income'
         )
      ),
      
      # give intro to user
      tags$p(
         tags$div(
            id = 'IncomeMapIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/incomeMapDesc.html')
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
            sliderInput("incYear", label = h3("Year"), min = 1992, 
                        max = 2010, value = 2000, sep = "", step = 2)
         ),
         
         # render the education map
         mainPanel(plotlyOutput('incMap')))
   ),
   
   # REPORT TAB =======================================================================================================
   tabPanel(
      # home page tab that reads in data from html/index.html
      titlePanel(
         tags$div(id = 'GlobalNavTab', 'Report'),
         windowTitle = 'Report'
      ),
      'REPORT TAB - Under construction'
   ),
   
   # MACHINE LEARNING TAB ==============================================================================================
   tabPanel(
      # home page tab that reads in data from html/index.html
      titlePanel(
         tags$div(id = 'GlobalNavTab', 'Machine Learning'),
         windowTitle = 'Machine Learning'
      ),
      'MACHINE LEARNING TAB - Under construction'
   )
   
   # END TABS ==========================================================================================================
   )
)
