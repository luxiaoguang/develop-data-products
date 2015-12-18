library(shiny)
library(rCharts)
options(RCHART_LIB = 'morris')
shinyUI(pageWithSidebar(
        headerPanel("Please Input Your Stock Code"),
        sidebarPanel(
                textInput('code','Stock Code',value = "^GSPC"),
                submitButton('Submit')
                
                
        ),
        mainPanel(
                h3('Downloading Please Wait ...'),
                h4('Your Stock'),
                verbatimTextOutput("ocode"),
                showOutput("chart1", "morris"),
                showOutput("chart2", "morris"),
                showOutput("chart3", "morris")
                
        )
))