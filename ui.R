library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  titlePanel("European Stock Market Data"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("slider1", "Pick Time (Year) Range", 
                   min = 1991, max = 1999, value = c(1991,1999), 
                   step = 1),
       h4("Please select at least 1 stock."),
       checkboxInput("box1", "Show stock: DAX", value = TRUE),
       checkboxInput("box2", "Show stock: SMI", value = TRUE),
       checkboxInput("box3", "Show stock: CAC", value = TRUE),
       checkboxInput("box4", "Show stock: FTSE", value = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Instructions", br(), htmlOutput("intro")),
                  tabPanel("Stock Market Plot", br(), plotlyOutput("plot1"))
      )
    )
  )
))
