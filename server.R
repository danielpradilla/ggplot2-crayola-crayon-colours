library(shiny)

source("ggplot-crayola.R")

shinyServer(
  function(input, output) {
  
    output$crayolachart <- renderPlot(print(final))

  }
)