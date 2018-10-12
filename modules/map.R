map_ui = function(id){
    ns = NS(id)
    tagList(
        leafletOutput(ns("map"))
    )
}

map_server = function(input,output,session, query_table){
    output$map <- renderLeaflet({
        m <- leaflet() %>%
            addTiles() %>%
            setView(lng=-73.935242, lat=40.730610 , zoom=10)
        m
    })
}