library(shiny)
library(ggplot2)

load( 'data/land.Rdata' )

shinyServer(function(input, output) {
  
  plotData <- reactive(function() {
    land[ (land$species==input$species)&(land$state==input$state), ]
  })
  
  output$speciesChooser <- renderUI({
    selectInput( 'species', 'Species',
                 levels(factor(land$species[land$state==input$state])))
  })
  
  output$plot <- reactivePlot(function() {
    
    p <- ggplot( plotData(), aes( date, tons ) )
    p <- p + geom_line()
    p<-p + xlim( as.Date( c( '1990-01-01', '2012-12-01' ) ) )
    p<-p+scale_x_date( breaks = as.Date( paste0( as.character( seq(1990,2013 ) ),
                                                 '-01-01' ) ),
                       labels = as.character( seq( 1990, 2013 ) ) )
    
    print(p)
    
  }, height=700)
  
})