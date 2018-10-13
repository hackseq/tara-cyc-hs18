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
        # I have removed the sample from here as it places points on top of each other
        # resulting in no effect
        samples = df %>% select(LAT, LONG, DEPTHM)  %>% unique
        
        
        m <- leaflet(data = samples) %>%
            addTiles() %>%
            
            setView(lng=12.491348, lat=41.902281 , zoom=4) %>% 
            addMarkers(lng = ~LONG,
                       lat = ~LAT ,
                       # popup = paste("sample: ", samples$SAMPLE, "<br/>",
                       #               "latitude: ", samples$LAT, "<br/>",
                       #               "longitude: ", samples$LONG, "<br/>",
                       #               "depth (m): ", samples$DEPTHM)
                       clusterOptions = markerClusterOptions())
            
        m
    })
    
    out = reactive({
        isolate({df = query_table()})
        
        if(!is.null(input$map_marker_click)){
            # return selected points
            df %>% 
                filter(LAT == input$map_marker_click$lat & LONG == input$map_marker_click$lng)  
        }

    })
    
    # return selected coordinates
    return(out)
}