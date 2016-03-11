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
      
      titlePanel(tags$div(id = "TabSectionHeader",
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
         mainPanel(plotlyOutput('crimeMap'))),
      
      # give intro to user
      tags$p(
         tags$div(
            id = 'TabIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/crimeMapDesc.html')
            )
         )
      )
   ),
   
   
   # EDUCATION TAB ===========================================================================================================
   tabPanel(
      titlePanel(
         tags$div(
            id = 'GlobalNavTab',
            'Education'
         )
      ),
      
      titlePanel(tags$div(id = "TabSectionHeader", 
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
         mainPanel(plotlyOutput('eduMap'))),
      
      # display map description
      tags$p(
         tags$div(
            id = 'TabIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/educationMapDesc.html')
            )
         )
      )
   ),
   
   # INCOME TAB ==============================================================================================================
   tabPanel(
      titlePanel(
         tags$div(
            id = 'GlobalNavTab',
            'Income'
         )
      ),
      
      titlePanel(tags$div(id = "TabSectionHeader",
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
         mainPanel(plotlyOutput('incMap'))),
      
      # give intro to user
      tags$p(
         tags$div(
            id = 'TabIntroBox',
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/incomeMapDesc.html')
            )
         )
      )
   ),
   
   # REPORT TAB =======================================================================================================
   tabPanel(
      # home page tab that reads in data from html/index.html
      titlePanel(
         tags$div(id = 'GlobalNavTab', 'Report'),
         windowTitle = 'Report'
      ),
      
      # UI SECTION FOR SUMMARY TABLE --------------------------------------
      titlePanel(tags$div(id = "TabSectionHeader",
                          'Interactive Report')),
      
      # Print the report description, wrapped in the text box
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/reportText.html')
                  )
               )
      ),
      
      titlePanel(tags$div(id = 'TabSectionHeader',
                          'At the State Level: The Extremes')),
      
      # Print the summary description, wrapped in the text box
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/sumTableText.html')
                  )
               )
      ),
      
      # render the summary table, centered horizontally
      fluidRow(
         column(12, align="center",
                tableOutput('sumTable')
         )
      ),
      
      # UI SECTION FOR HISTOGRAM ---------------------------------------------
      titlePanel(tags$div(id = "TabSectionHeader",
                          'At the State Level: A Comparison Tool')),
      
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/sumHistText.html')
                  )
               )
      ),
      
      sidebarLayout(
         
         sidebarPanel(
            
            # Define a drop-dwon style input with all three crime types
            selectInput("histDataType", label = h3("Data"),
                        choices = list(
                           'Crime' = 'Crime',
                           'Education' = 'Education',
                           'Income' = 'Income'
                        )
            ),
            
            sliderInput("histYear", label = h3("Year"), min = 1992, 
                        max = 2010, value = 2000, sep = "", step = 2),
            
            # Define a drop-down style input with all 50 states for first state choice
            selectInput("histStateOne", label = h3("State One"),
                        choices = list(
                           'Alabama' = 'AL',
                           'Alaska' = 'AK',
                           'Arizona' = 'AZ',
                           'Arkansas' = 'AR',
                           'California' = 'CA',
                           'Colorado' = 'CO',
                           'Connecticut' = 'CT',
                           'Delaware' = 'DE',
                           'Florida' = 'FL',
                           'Georgia' = 'GA',
                           'Hawaii' = 'HI',
                           'Idaho' = 'ID',
                           'Illinois' = 'IL',
                           'Indiana' = 'IN',
                           'Iowa' = 'IA',
                           'Kansas' = 'KS',
                           'Kentucky' = 'KY',
                           'Louisiana' = 'LA',
                           'Maine' = 'ME',
                           'Maryland' = 'MD',
                           'Massachusetts' = 'MA',
                           'Michigan' = 'MI',
                           'Minnesota' = 'MN',
                           'Mississippi' = 'MS',
                           'Missouri' = 'MO',
                           'Montana' = 'MT',
                           'Nebraska' = 'NE',
                           'Nevada' = 'NV',
                           'New Hampsire' = 'NH',
                           'New Jersey' = 'NJ',
                           'New Mexico' = 'NM',
                           'New York' = 'NY',
                           'North Carolina' = 'NC',
                           'North Dakota' = 'ND',
                           'Ohio' = 'OH',
                           'Oklahoma' = 'OK',
                           'Oregon' = 'OR',
                           'Pennsylvania' = 'PA',
                           'Rhode Island' = 'RI',
                           'South Carolina' = 'SC',
                           'South Dakota' = 'SD',
                           'Tennessee' = 'TN',
                           'Texas' = 'TX',
                           'Utah' = 'UT',
                           'Vermont' = 'VT',
                           'Virginia' = 'VA',
                           'Washington' = 'WA',
                           'West Virgina' = 'WV',
                           'Wisconsin' = 'WI',
                           'Wyoming' = 'WY'
                        ), selected = 'NM'
            ),
            
            # Define a drop-down style input with all 50 states for second state choice
            selectInput("histStateTwo", label = h3("State Two"),
                        choices = list(
                           'Alabama' = 'AL',
                           'Alaska' = 'AK',
                           'Arizona' = 'AZ',
                           'Arkansas' = 'AR',
                           'California' = 'CA',
                           'Colorado' = 'CO',
                           'Connecticut' = 'CT',
                           'Delaware' = 'DE',
                           'Florida' = 'FL',
                           'Georgia' = 'GA',
                           'Hawaii' = 'HI',
                           'Idaho' = 'ID',
                           'Illinois' = 'IL',
                           'Indiana' = 'IN',
                           'Iowa' = 'IA',
                           'Kansas' = 'KS',
                           'Kentucky' = 'KY',
                           'Louisiana' = 'LA',
                           'Maine' = 'ME',
                           'Maryland' = 'MD',
                           'Massachusetts' = 'MA',
                           'Michigan' = 'MI',
                           'Minnesota' = 'MN',
                           'Mississippi' = 'MS',
                           'Missouri' = 'MO',
                           'Montana' = 'MT',
                           'Nebraska' = 'NE',
                           'Nevada' = 'NV',
                           'New Hampsire' = 'NH',
                           'New Jersey' = 'NJ',
                           'New Mexico' = 'NM',
                           'New York' = 'NY',
                           'North Carolina' = 'NC',
                           'North Dakota' = 'ND',
                           'Ohio' = 'OH',
                           'Oklahoma' = 'OK',
                           'Oregon' = 'OR',
                           'Pennsylvania' = 'PA',
                           'Rhode Island' = 'RI',
                           'South Carolina' = 'SC',
                           'South Dakota' = 'SD',
                           'Tennessee' = 'TN',
                           'Texas' = 'TX',
                           'Utah' = 'UT',
                           'Vermont' = 'VT',
                           'Virginia' = 'VA',
                           'Washington' = 'WA',
                           'West Virgina' = 'WV',
                           'Wisconsin' = 'WI',
                           'Wyoming' = 'WY'
                        ), selected = 'WA'
            ),
            
            # Define a drop-down style input with all 50 states for third state choice
            selectInput("histStateThree", label = h3("State Three"),
                        choices = list(
                           'Alabama' = 'AL',
                           'Alaska' = 'AK',
                           'Arizona' = 'AZ',
                           'Arkansas' = 'AR',
                           'California' = 'CA',
                           'Colorado' = 'CO',
                           'Connecticut' = 'CT',
                           'Delaware' = 'DE',
                           'Florida' = 'FL',
                           'Georgia' = 'GA',
                           'Hawaii' = 'HI',
                           'Idaho' = 'ID',
                           'Illinois' = 'IL',
                           'Indiana' = 'IN',
                           'Iowa' = 'IA',
                           'Kansas' = 'KS',
                           'Kentucky' = 'KY',
                           'Louisiana' = 'LA',
                           'Maine' = 'ME',
                           'Maryland' = 'MD',
                           'Massachusetts' = 'MA',
                           'Michigan' = 'MI',
                           'Minnesota' = 'MN',
                           'Mississippi' = 'MS',
                           'Missouri' = 'MO',
                           'Montana' = 'MT',
                           'Nebraska' = 'NE',
                           'Nevada' = 'NV',
                           'New Hampsire' = 'NH',
                           'New Jersey' = 'NJ',
                           'New Mexico' = 'NM',
                           'New York' = 'NY',
                           'North Carolina' = 'NC',
                           'North Dakota' = 'ND',
                           'Ohio' = 'OH',
                           'Oklahoma' = 'OK',
                           'Oregon' = 'OR',
                           'Pennsylvania' = 'PA',
                           'Rhode Island' = 'RI',
                           'South Carolina' = 'SC',
                           'South Dakota' = 'SD',
                           'Tennessee' = 'TN',
                           'Texas' = 'TX',
                           'Utah' = 'UT',
                           'Vermont' = 'VT',
                           'Virginia' = 'VA',
                           'Washington' = 'WA',
                           'West Virgina' = 'WV',
                           'Wisconsin' = 'WI',
                           'Wyoming' = 'WY'
                        ), selected = 'NV'
            )
         ),
         mainPanel(plotlyOutput('histogram'))),
      
      
      
      # UI SECTION FOR LINEAR PLOT ------------------------------------
      titlePanel(tags$div(id = "TabSectionHeader",
                          'At the National Level: A High Level Comparison')),
      
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/linePlotText.html')
                  )
               )
      ),
      
      # define sidebar
         sidebarLayout(
            
            sidebarPanel(
               
               sliderInput("linearPlot", label = h3("Year Range"), min = 1992, 
                           max = 2010, value = c(1996, 2006), sep = "", step = 2)
            ),
            
            # render the linear plot
            mainPanel(plotlyOutput('linPlot'))),
      
      
      # UI SPOT FOR TIME ANALYSIS GRAPH -----------------------------------
      titlePanel(tags$div(id = "TabSectionHeader",
                          'At the State or National Level: Statistical Trends')),
      
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/timeAnalysisText.html')
                  )
               )
      ),
      
         sidebarLayout(
            
            sidebarPanel(
               
               # Define a drop-dwon style input with all three crime types
               selectInput("timeDataChoice", label = h3("Data"),
                           choices = list(
                              'Crime' = 'Crime',
                              'Education' = 'Education',
                              'Income' = 'Income'
                           )
               ),
               
               # Define a drop-down style input with all 50 states + US
               selectInput("timeStateChoice", label = h3("State"),
                           choices = list(
                              'United States' = 'TOT',
                              'Alabama' = 'AL',
                              'Alaska' = 'AK',
                              'Arizona' = 'AZ',
                              'Arkansas' = 'AR',
                              'California' = 'CA',
                              'Colorado' = 'CO',
                              'Connecticut' = 'CT',
                              'Delaware' = 'DE',
                              'Florida' = 'FL',
                              'Georgia' = 'GA',
                              'Hawaii' = 'HI',
                              'Idaho' = 'ID',
                              'Illinois' = 'IL',
                              'Indiana' = 'IN',
                              'Iowa' = 'IA',
                              'Kansas' = 'KS',
                              'Kentucky' = 'KY',
                              'Louisiana' = 'LA',
                              'Maine' = 'ME',
                              'Maryland' = 'MD',
                              'Massachusetts' = 'MA',
                              'Michigan' = 'MI',
                              'Minnesota' = 'MN',
                              'Mississippi' = 'MS',
                              'Missouri' = 'MO',
                              'Montana' = 'MT',
                              'Nebraska' = 'NE',
                              'Nevada' = 'NV',
                              'New Hampsire' = 'NH',
                              'New Jersey' = 'NJ',
                              'New Mexico' = 'NM',
                              'New York' = 'NY',
                              'North Carolina' = 'NC',
                              'North Dakota' = 'ND',
                              'Ohio' = 'OH',
                              'Oklahoma' = 'OK',
                              'Oregon' = 'OR',
                              'Pennsylvania' = 'PA',
                              'Rhode Island' = 'RI',
                              'South Carolina' = 'SC',
                              'South Dakota' = 'SD',
                              'Tennessee' = 'TN',
                              'Texas' = 'TX',
                              'Utah' = 'UT',
                              'Vermont' = 'VT',
                              'Virginia' = 'VA',
                              'Washington' = 'WA',
                              'West Virgina' = 'WV',
                              'Wisconsin' = 'WI',
                              'Wyoming' = 'WY'
                           )
                        )
            ),
            mainPanel(plotlyOutput('timeAnalysis'))),
      
      # UI SECTION FOR Cross Analysis
      titlePanel(tags$div(id = "TabSectionHeader",
                          'At the Overall Data Level: CrossAnalysis')),
      
      tags$div(id = 'TabIntroBox',
               tags$p(
                  tags$div(
                     id = 'GlobalMapIntro',
                     includeHTML('html/intros/crossAnalysisText.html')
                  )
               )
      ),
      
      sidebarLayout(
         
         sidebarPanel(
            
            # Define a drop-down style input with all 50 states
            selectInput("crossState", label = h3("State"),
                        choices = list(
                           'Alabama' = 'AL',
                           'Alaska' = 'AK',
                           'Arizona' = 'AZ',
                           'Arkansas' = 'AR',
                           'California' = 'CA',
                           'Colorado' = 'CO',
                           'Connecticut' = 'CT',
                           'Delaware' = 'DE',
                           'Florida' = 'FL',
                           'Georgia' = 'GA',
                           'Hawaii' = 'HI',
                           'Idaho' = 'ID',
                           'Illinois' = 'IL',
                           'Indiana' = 'IN',
                           'Iowa' = 'IA',
                           'Kansas' = 'KS',
                           'Kentucky' = 'KY',
                           'Louisiana' = 'LA',
                           'Maine' = 'ME',
                           'Maryland' = 'MD',
                           'Massachusetts' = 'MA',
                           'Michigan' = 'MI',
                           'Minnesota' = 'MN',
                           'Mississippi' = 'MS',
                           'Missouri' = 'MO',
                           'Montana' = 'MT',
                           'Nebraska' = 'NE',
                           'Nevada' = 'NV',
                           'New Hampsire' = 'NH',
                           'New Jersey' = 'NJ',
                           'New Mexico' = 'NM',
                           'New York' = 'NY',
                           'North Carolina' = 'NC',
                           'North Dakota' = 'ND',
                           'Ohio' = 'OH',
                           'Oklahoma' = 'OK',
                           'Oregon' = 'OR',
                           'Pennsylvania' = 'PA',
                           'Rhode Island' = 'RI',
                           'South Carolina' = 'SC',
                           'South Dakota' = 'SD',
                           'Tennessee' = 'TN',
                           'Texas' = 'TX',
                           'Utah' = 'UT',
                           'Vermont' = 'VT',
                           'Virginia' = 'VA',
                           'Washington' = 'WA',
                           'West Virgina' = 'WV',
                           'Wisconsin' = 'WI',
                           'Wyoming' = 'WY'
                        )
            ),
            
            # Define a drop-dwon style input with all three crime types for first data type
            selectInput("crossDataOne", label = h3("Data"),
                        choices = list(
                           'Crime' = 'Crime',
                           'Education' = 'Education',
                           'Income' = 'Income'
                        )
            ),
            
            # Define a drop-dwon style input with all three crime types for second data type
            selectInput("crossDataTwo", label = h3("Data"),
                        choices = list(
                           'Crime' = 'Crime',
                           'Education' = 'Education',
                           'Income' = 'Income'
                        )
            )
            
         ),
         mainPanel(plotlyOutput('crossAnalysis')))
      
      
      
   ),
   
   # PREDICTION TAB ==============================================================================================
   tabPanel(
      # home page tab that reads in data from html/index.html
      titlePanel(
         tags$div(id = 'GlobalNavTab', 'Prediction'),
         windowTitle = 'Prediction'
      ),
      
      titlePanel(tags$div(id = "TabSectionHeader",
                          'Education Prediction')),
      
      tags$div(id = 'TabIntroBox',
         mainPanel(plotOutput('PredictEdu')),
      
      tags$p(
            tags$div(
               id = 'GlobalMapIntro',
               includeHTML('html/intros/PredictEducationWriteup.html')
            )
         )
      )
      
   )
   
   # END TABS ==========================================================================================================
   )
)
