table_ui = function(id){
    ns = NS(id)
    tagList(
        actionButton(ns('select_group'),icon = icon('save'), label = 'Select Group'),
        textInput(ns('group_name'), label = 'Name Group'),
        DT::dataTableOutput(ns('query_dt'))
    )
}

table_server = function(input,output,session, query_table){
    
    output$query_dt = DT::renderDataTable({
        df = query_table()
        
        samples = df %>% select(SAMPLE,TYPE,DEPTH,LAT,LONG,BIOME,GEOREGION,virus) %>% unique
    })
    
    outSample = reactive({
        df = query_table()
        samples = df %>% select(SAMPLE,TYPE,DEPTH,LAT,LONG,BIOME,GEOREGION,virus) %>% unique
        chosenSamples = samples[input$query_dt_rows_selected,]
        
        df %>% filter(SAMPLE %in% chosenSamples$SAMPLE)
    })
    
    outGroup = reactive({

        if(input$select_group >= 1 ){
            isolate({
                df = query_table()
                if(!is.null(input$query_dt_rows_selected)){
                    samples = df %>% select(SAMPLE,TYPE,DEPTH,LAT,LONG,BIOME,GEOREGION,virus) %>% unique
                    chosenSamples = samples[input$query_dt_rows_selected,]
                    out = df %>% filter(SAMPLE %in% chosenSamples$SAMPLE)
                } else{
                    out = df
                }
                
                if(is.null(input$group_name) | input$group_name == ''){
                    name = glue('unnamed ({length(unique(out$SAMPLE))} samples)')
                } else{
                    name = input$group_name
                }
                
                return(list(name = name,
                            subset = out))

            })
        }
    })
    
    return(list(group = outGroup,sample = outSample))
    
}
