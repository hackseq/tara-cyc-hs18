table_ui = function(id){
    ns = NS(id)
    tagList(
        fluidRow(
            column(6,
                   div(style="display:inline-block", actionButton(ns('select_group'),icon = icon('save'), label = 'Select Group')),
                   div(style="display:inline-block", textInput(ns('group_name'), label = 'Name Group',width = 200))
            ),
            column(4),
            column(2,downloadButton(style = "display:inline-block float:right",outputId = ns('data_down'),label = 'Download Selection'))),
        DT::dataTableOutput(ns('query_dt'))
    )
}

table_server = function(input,output,session, query_table){
    
    
    downloadPress = reactiveVal(value = 0)
    
    output$data_down = downloadHandler(
        filename = 'voyagerdata.tsv',
        content = function(file){
            downloadPress(downloadPress()+1)
            write_tsv(outGroup()$subset,file)
        }
    )
    
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
        if(input$select_group >= 1 | downloadPress()>=1){
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
    
    sendGroupOut = reactive({
        if(input$select_group >= 1){
            isolate({
                outGroup()
            })
        }
    })
    
    return(list(group = sendGroupOut,sample = outSample))
    
}
