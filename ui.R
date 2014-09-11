library(shiny)

shinyUI(
  fluidPage(
    headerPanel('Crayola colors'),
    div(id="intro", class="span12 well",
      p('Shiny exercise based on ',
        a(href="http://learnr.wordpress.com/2010/01/21/ggplot2-crayola-crayon-colours/","http://learnr.wordpress.com/2010/01/21/ggplot2-crayola-crayon-colours")
      ),
      p('Taking data from ',
          a(href="http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors","The Wikipedia page on Crayola Colors")
      ),
      div(id="author",a(href="https://github.com/danielpradilla","Daniel Pradilla"))
    ),
    mainPanel(
                div(class="chartcontainer",
                  h3('Crayola Colors'),
                  plotOutput("crayolachart"))
    )
  )
)