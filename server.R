library(shiny)
library(plotly)
library(tidyr)
library(dplyr)

shinyServer(function(input, output) {
   
  box_DAX <- reactive({input$box1})
  box_SMI <- reactive({input$box2})
  box_CAC <- reactive({input$box3})
  box_FTSE <- reactive({input$box4})
  time_range <- reactive({input$slider1})
  
  output$plot1 <- renderPlotly({
    stocks <- as.data.frame(EuStockMarkets) %>%
              gather(index, price) %>%
              mutate(time = rep(time(EuStockMarkets),4))
    stock_cont <- data.frame()
    if(box_DAX()) {
      stock_cont <- rbind(stock_cont,subset(stocks, stocks$index == "DAX"))
    }
    if(box_SMI()) {
      stock_cont <- rbind(stock_cont,subset(stocks, stocks$index == "SMI"))
    }
    if(box_CAC()) {
      stock_cont <- rbind(stock_cont,subset(stocks, stocks$index == "CAC"))
    }
    if(box_FTSE()) {
      stock_cont <- rbind(stock_cont,subset(stocks, stocks$index == "FTSE"))
    }
    stock_cont <- subset(stock_cont, stock_cont$time >= time_range()[1] & stock_cont$time <= time_range()[2])
    
    if(nrow(stock_cont) > 0) {
      plot_ly(stock_cont, x = stock_cont$time, y = stock_cont$price, color = stock_cont$index) %>%
        layout(title = "European Stock Market Prices", 
               yaxis = list(title = "Stock Price"), 
               xaxis = list(title = "Year"))
    }
  })
  
  output$intro <- renderText({
    paste(
          "<h3>", "Introduction", "</h3>",
          "<br>",
          "<h5>", "This Shiny application is designed to help the user interactively view 
                   the 4 indexes of the European Stock Market.", 
          "</h5>",
          "</br>",
          
          "<h3>", "How to Navigate", "</h3>",
          "<br>",
           "<h5>", "In the next tab ('Stock Market Plot') is an interactive plot for the dataset ",
            "<b>", "EuStockMarkets. ", "</b>",
            "The interactive plot can select up to 4 different stocks between the time frame of 1991 to 1999: ",
           "<br>","</br>",
            "<ul>",
             "<li>", "DAX - Deutscher Aktienindex, German Stock Index", "</li>",
             "<li>", "SMI - Swiss Market Index", "</li>",
             "<li>", "CAC - Cotation Assistée en Continu 40 Index", "</li>",
             "<li>", "FTSE - Financial Times Stock Exchange 100 Index", "</li>",
            "</ul>",
          "<br>","</br>",
            "The slider on the left can be used to select the range of timeline for the stocks (1991 to 1999). 
             The boxes to the left can be used to select the stocks to display on the plot.",
          "</h5>",
          "</br>"
          
          )
    
  })
  
})
