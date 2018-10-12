map_ui = function(id){
    ns = NS(id)
    tagList(
        leafletOutput(ns("map"))
    )
}

map_server = function(input,output,session, query_table){
    output$map <- renderLeaflet({
        print(head(query_table()))
        
        
        df = query_table()
        samples = df %>% select(SAMPLE, LAT, LONG)  %>% unique
        
        
        m <- leaflet(data = samples) %>%
            addTiles() %>%
            setView(lng=-73.935242, lat=40.730610 , zoom=10) %>% 
            addMarkers(lng = ~LONG,
                       lat = ~LAT)
            
        m
    })
}