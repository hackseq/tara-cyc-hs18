map_ui = function(id){
    ns = NS(id)
    tagList(
        actionButton(ns('select_group'),icon = icon('save'), label = 'Select Group'),
        textInput(ns('group_name'), label = 'Name Group',width = 200),
        editModUI(ns('map_edit'), height = 600)
    )
}

map_server = function(input,output,session, query_table){
    
    map = reactive({
        df = query_table()
        # I have removed the sample from here as it places points on top of each other
        # resulting in no effect
        samples = df %>% select(LAT, LONG)  %>% unique
        
        # element ID is ifgnored always called map
        m <- leaflet(data = samples) %>%
            addProviderTiles(providers$Esri.WorldImagery) %>% 
            # addTiles() %>%
            setView(lng=-10, lat=0 , zoom=2) %>% 
            addMarkers(lng = ~LONG,
                       lat = ~LAT ,
                       clusterOptions = markerClusterOptions()) 
        
        m
    })
    
    mapSelection = callModule(
        editModEdit,
        'map_edit',
        map
    )
    
    
    outSample = reactive({
        isolate({df = query_table()})
        
        if(!is.null(input$`map_edit-map_marker_click`)){
            # browser()
            # return selected points
            df %>% 
                filter(LAT == input$`map_edit-map_marker_click`$lat & LONG == input$`map_edit-map_marker_click`$lng)  
        }

    })
    
    outGroup = reactive({
        if(input$select_group >= 1 )
        isolate({
            if(is.null(mapSelection()$finished)){
                out = query_table()
            } else{
                withProgress({
                    query_table() %>% mutate(long = LONG, lat = LAT) %>% 
                        select(long,lat) %>%as.matrix %>% st_multipoint() ->multipoint
                    
                    toIntersect = st_sf(st_cast(st_sfc(multipoint), "POINT"), query_table(), crs=4326)
                    selection = mapSelection()$finished
                    intersection = st_intersection(selection, toIntersect)
                    
                    out = intersection[,names(query_table())]
                    
                    if(nrow(out) == 0){
                        out = query_table()
                    }
                },value = 1,message = 'Picking samples')

            }
            
            if(is.null(input$group_name) | input$group_name == ''){
                name = glue('unnamed ({length(unique(out$SAMPLE))} samples)')
            } else{
                name = input$group_name
            }
            return(list(name = name,
                          subset = out %>% as.data.frame() %>% {.[names(query_table())]}))
            
        })
        })
    
    
    return(list(group = outGroup,sample = outSample))
    
}



editModEdit = function (input, output, session, leafmap, targetLayerId = NULL, 
                        sf = TRUE, record = FALSE, crs = 4326) 
{

    output$map <- leaflet::renderLeaflet({
        leafmap = leafmap()
        if (is.null(Find(function(cl) {
            cl$method == "addDrawToolbar"
        }, leafmap$x$calls))) {
            leafmap <- leaflet.extras::addDrawToolbar(leafmap, targetGroup = targetLayerId, 
                                                      polylineOptions = FALSE, 
                                                      polygonOptions = leaflet.extras::drawPolygonOptions(repeatMode = TRUE), 
                                                      circleOptions = FALSE, 
                                                      rectangleOptions = leaflet.extras::drawRectangleOptions(repeatMode = TRUE), 
                                                      markerOptions = FALSE, 
                                                      circleMarkerOptions = FALSE, 
                                                      editOptions = leaflet.extras::editToolbarOptions())
        }
        
        leafmap
        
    })
    featurelist <- reactiveValues(drawn = list(), edited_all = list(), 
                                  deleted_all = list(), finished = list())
    recorder <- list()
    EVT_DRAW <- "map_draw_new_feature"
    EVT_EDIT <- "map_draw_edited_features"
    EVT_DELETE <- "map_draw_deleted_features"
    shiny::observeEvent(input[[EVT_DRAW]], {
        featurelist$drawn <- c(featurelist$drawn, list(input[[EVT_DRAW]]))
        if (any(unlist(input[[EVT_DRAW]]$geometry$coordinates) < 
                -180) || any(unlist(input[[EVT_DRAW]]$geometry$coordinates) > 
                             180)) 
            insane_longitude_warning()
        featurelist$finished <- c(featurelist$finished, list(input[[EVT_DRAW]]))
    })
    shiny::observeEvent(input[[EVT_EDIT]], {
        edited <- input[[EVT_EDIT]]
        ids <- unlist(lapply(featurelist$finished, function(x) {
            x$properties$`_leaflet_id`
        }))
        lapply(edited$features, function(x) {
            loc <- match(x$properties$`_leaflet_id`, ids)
            if (length(loc) > 0) {
                featurelist$finished[loc] <<- list(x)
            }
        })
        featurelist$edited_all <- c(featurelist$edited_all, list(edited))
    })
    shiny::observeEvent(input[[EVT_DELETE]], {
        deleted <- input[[EVT_DELETE]]
        ids <- unlist(lapply(featurelist$finished, function(x) {
            x$properties$`_leaflet_id`
        }))
        lapply(deleted$features, function(x) {
            loc <- match(x$properties$`_leaflet_id`, ids)
            if (length(loc) > 0) {
                featurelist$finished[loc] <<- NULL
            }
        })
        featurelist$deleted_all <- c(featurelist$deleted_all, 
                                     list(deleted))
    })
    if (record == TRUE) {
        lapply(c(EVT_DRAW, EVT_EDIT, EVT_DELETE), function(evt) {
            observeEvent(input[[evt]], {
                recorder <<- c(recorder, list(list(event = evt, 
                                                   timestamp = Sys.time(), feature = input[[evt]])))
            })
        })
    }
    returnlist <- reactive({
        workinglist <- list(drawn = featurelist$drawn, edited = featurelist$edited_all, 
                            deleted = featurelist$deleted_all, finished = featurelist$finished)
        if (sf) {
            workinglist <- lapply(workinglist, function(action) {
                if (length(action) == 0) {
                    return()
                }
                features <- Reduce(function(left, right) {
                    if (right$type == "FeatureCollection") {
                        right <- lapply(right$features, identity)
                    }
                    else {
                        right <- list(right)
                    }
                    c(left, right)
                }, action, init = NULL)
                mapedit:::combine_list_of_sf(lapply(features, mapedit:::st_as_sf.geo_list, 
                                          crs = crs))
            })
            recorder <- lapply(recorder, function(evt) {
                feature = mapedit:::st_as_sfc.geo_list(evt$feature, crs = crs)
                list(evt = evt$event, timestamp = evt$timestamp, 
                     feature = feature)
            })
        }
        if (record == TRUE) {
            attr(workinglist, "recorder") <- recorder
        }
        return(workinglist)
    })
    return(returnlist)
}