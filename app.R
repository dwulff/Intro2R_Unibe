#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
library(baselers)

data <- read_csv("1_Data/baselers.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("My First Shiny App!"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      textInput(inputId = "title",
                label = "Title",
                value = "Plot Title"),
      
      textInput(inputId = "subtitle",
                label = "Subtitle",
                value = ""),
      
      
      textInput(inputId = "caption",
                label = "Caption",
                value = ""),
      
      
      selectInput(inputId = "x",
                  label = "x",
                  choices = names(data),
                  selected = "age"),
      
      selectInput(inputId = "y",
                  label = "y",
                  choices = names(data),
                  selected = "income"),
      
      selectInput(inputId = "color",
                  label = "Point colors",
                  choices = colors(),
                  selected = "black"),
      
      sliderInput("alpha",
                  "alpha",
                  min = 0,
                  max = 1,
                  value = 1),
      
      checkboxInput(inputId = "smooth",
                    label = "Add Regression line?",
                    value = FALSE),
      downloadButton(outputId = "down", 
                     label = "Download the plot")
      
    ),
    
    mainPanel(
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("distPlot")),
                  tabPanel("Data", dataTableOutput("summary")),
                  tabPanel("Description",
                           h3("Shiny is Awesome!"),
                           p("You can really do anything with Shiny!"),
                           a("Click me to go to the Shiny page",
                             href = "https://shiny.rstudio.com/gallery/")
                  )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  
  output$distPlot <- renderPlot({
    
    p <- ggplot(data = data,
                aes_string(x = input$x, 
                           y = input$y)) + 
      geom_point(alpha = input$alpha, col = input$color)
    
    
    if(input$smooth) {
      
      p <- p + geom_smooth(method = "lm")
      
    }
    
    
    print(p)
    
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)

