library(shiny)
library(datasets)


shinyServer(function(input, output) {
  output$box <- renderPlot({
    if(input$type == "2010"){
      print(placa_2010)}
    else if (input$type == "2011"){
      print(placa_2011)}
    else if (input$type == "2012"){
      print(placa_2012)}
    else if (input$type == "2013"){
      print(placa_2013)}
    else if (input$type == "2014"){
      print(placa_2014)}
    else if (input$type == "2015"){
      print(placa_2015)}
    else if (input$type == "2016"){
      print(placa_2016)}
    else if (input$type == "2017"){
      print(placa_2017)}
  })
}
)