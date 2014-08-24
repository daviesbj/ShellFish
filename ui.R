library(shiny)
library(ggplot2)

load( 'data/land.Rdata' )

shinyUI(pageWithSidebar(
  
  headerPanel("Atlantic/Gulf Fisheries Explorer"),
  
  sidebarPanel(
    
    selectInput( 'state',   'State',
                 levels( land$state ),
                 selected ='Louisiana'  ),
    
    # selectInput( 'species', 'Species',
    #              levels( land$species ),
    #              selected = 'OYSTER, EASTERN' )
    uiOutput('speciesChooser')

  ),
  
  mainPanel(
    plotOutput('plot')
  )
))