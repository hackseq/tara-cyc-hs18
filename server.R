#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    query_table = reactiveVal(tara_data)
    
    callModule(query_server,'query',query_table)
    
    mapChoice = callModule(map_server,'map', query_table)
    
    callModule(sample_server,'sample',mapChoice)
  
})
