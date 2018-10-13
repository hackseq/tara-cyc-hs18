
sample_ui = function(id){
    ns = NS(id)
    tagList(
        htmlOutput(ns('sample_tab_render')),
        dataTableOutput(ns('sample_datatable'))
    )
}

sample_server = function(input,output,session,mapChoice){
    
    output$sample_tab_render = renderUI({
        df = mapChoice()
        df$SAMPLE %>% unique %>% lapply(function(sample){
            sample_subset = df %>% filter(SAMPLE==sample)
            # this assumes some properties are universal per sample
            # correct me if I'm wrong
            tabPanel(sample,
                     p(glue('LAT: {sample_subset$LAT[1]}')),
                     p(glue('LONG: {sample_subset$LONG[1]}')),
                     p(glue('Depth: {sample_subset$DEPTH[1]}')),
                     p(glue('Depth: {sample_subset$BIOME[1]}')),
                     p(glue('Virus?: {sample_subset$virus[1]}')))
        }) -> tabs

        # here session$ns() is needed in order to make this element accessible to 
        # the rest of the module. it is equivalent to using ns() function in
        # UI code but server code doesn't know its own id without accessing the
        # session variable
        do.call(tabsetPanel,c(id = session$ns('sample_tabs'), tabs))
    })
    
    # I separated this as a reactive becasue its used twice
    table_frame = reactive({
        if(!is.null(input$sample_tabs)){
            df = mapChoice()
            df %<>% filter(SAMPLE == input$sample_tabs)
            return(df)
        }
    })
    
    output$sample_datatable = DT::renderDataTable({
        table_frame()
    }, selection = list(mode= 'single',target = 'row'))
    
    
    observe({
        pathName = table_frame()[input$sample_datatable_rows_selected,]$PWY_NAME
        pathPeasantName = table_frame()[input$sample_datatable_rows_selected,]$PWY_COMMON_NAME
        giflink = glue('https://biocyc.org/tmp/ptools-images/META/{pathName}_PWY-DIAGRAM.gif')
        if(length(giflink)==1){
            showModal(
                modalDialog(title=pathPeasantName,
                            img(src = giflink),
                            easyClose = TRUE)
            )
        }
    })
}


