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
        samples = df %>% select(SAMPLE, LAT, LONG, DEPTHM)  %>% unique
        
        
        m <- leaflet(data = samples) %>%
            addTiles() %>%
            
            setView(lng=12.491348, lat=41.902281 , zoom=4) %>% 
            addMarkers(lng = ~LONG,
                       lat = ~LAT,
                       popup = paste("sample: ", samples$SAMPLE, "<br/>",
                                     "latitude: ", samples$LAT, "<br/>",
                                     "longitude: ", samples$LONG, "<br/>",
                                     "depth (m): ", samples$DEPTHM))
            
        m
    })
}