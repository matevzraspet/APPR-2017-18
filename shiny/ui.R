library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("Povprečne plače po občinah Slovenije"), 
  sidebarLayout(
    sidebarPanel(
      selectInput("type",label="Leto",
                  choice=c("2010", "2011", "2012","2013",
                           "2014", "2015","2016","2017")
                          
      )
    ),
    mainPanel(plotOutput("box")
    ) 
    
  )))