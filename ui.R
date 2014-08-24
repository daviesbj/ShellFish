library(shiny)
library(ggplot2)

load( 'data/hland.Rdata' )

shinyUI(pageWithSidebar(
  
  headerPanel("Atlantic/Gulf Fishery Incident Explorer"),
  
  sidebarPanel(
    
    selectInput( 'state',   'State',
                 levels( hland$state ),
                 selected ='Louisiana'  ),
    
    # selectInput( 'species', 'Species',
    #              levels( hland$species ),
    #              selected = 'OYSTER, EASTERN' )
    
    uiOutput( 'speciesChooser' ),
    
    h3( "Instructions" ),
    h4( 'Choose a state and a species to see a graph' ),
    h5( 'A good one to try is Louisiana and OYSTER, EASTERN' ),
    p( paste0( 'The application will use your input to select the data to plot from ',
               'its underlying data tables. As a convenience, it also uses your ',
               'State selection to restrict the list of species to those fished in the state')
    ),
    p( 'Note to markers -- this is how the application processes your input' ),
    p( paste0( 'The graph shows the available fishery landings history for your ',
               'selected species and state, with named hurricanes and other incidents that hit ',
               'the state during the period 1990-2012 that may have affected fishery activity, ',
               'coded by color and symbol size to indicate magnitude' )
    ),
    p( 'The graph looks better if you stretch the window horizontally' )

  ),
  
  mainPanel(
    plotOutput( 'plot' )
  )
))