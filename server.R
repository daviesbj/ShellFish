library(shiny)
library(ggplot2)

load( 'data/hland.Rdata' )

shinyServer(function(input, output) {
  
  plotData <- reactive(function() {
    hland[ (hland$species==input$species)&(hland$state==input$state), ]
  })
  
  output$speciesChooser <- renderUI({
    selectInput( 'species', 'Species',
                 levels(factor(hland$species[hland$state==input$state])))
  })
  
  output$plot <- reactivePlot(function() {
    
    p <- ggplot( plotData(), aes( date.x, tons ) )
    p <- p + geom_line()
    p <- p + geom_point( aes( size = level, color = type ) )
    p <- p + geom_text( aes( label = name ) )
    p <- p + xlim( as.Date( c( '1990-01-01', '2012-12-01' ) ) )
    p <- p + scale_x_date( breaks = as.Date( paste0( as.character( seq(1990,2013 ) ),
                                                 '-01-01' ) ),
                           labels = as.character( seq( 1990, 2013 ) ) )
    p <- p + expand_limits( y = 0 )
    p <- p + xlab( 'Date' ) + ylab( 'Tons Landed Per Month' )
    # p <- p + main( 'Main Title' )
    
    print(p)
    
  }, height = 700 )
  
})