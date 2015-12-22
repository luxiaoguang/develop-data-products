library(shiny)
library(rCharts)
options(RCHART_LIB = 'morris')
shinyUI(pageWithSidebar(
        headerPanel("Stock Price Forecast"),
        sidebarPanel(
                

                textInput('code',label=paste('Please Input Your Stock shortCode.', 
                               'E.g.',
                               '^DJI ( shortcode for Dow Jones Industrial Average )' , 
                               '^GSPC ( shortcode for S&P 500 )', 
                               '^IXIC ( shortcode for NASDAQ Composite )', 
                               'AAPL ( shortcode for Apple Inc. )', 
                               'You can look at Yahoo Finance webpage to find more shortcodes.',
                               'The default now is ^GSPC.', 
                               'Pls wait interactive chart to display. It will take a few seconds.'),
                               value = "^GSPC"),
                submitButton('Submit')
                
                
        ),
        mainPanel(
                h3('Forecasting Please Wait ...'),
                h4('Your Stock Code'),
                verbatimTextOutput("ocode"),
                h4('1. Close Price with Trend'),
                showOutput("chart1", "morris"),
                h4('2. Seasonal Fluctuation'),
                showOutput("chart2", "morris"),
                h4('3. Close Price with Forecast Prices'),
                showOutput("chart3", "morris")
                
        )
))