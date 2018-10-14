
shinyServer(function(input, output,session) {

    query_table = reactiveVal(tara_data)

    callModule(query_server,'query',tara_data,query_table)

    mapOut =  callModule(map_server,'map', query_table)

    tableOut = callModule(table_server,'table',query_table)
    
    mapOrTable = reactive({
        input$map_or_table
    })
    
    callModule(sample_server,'sample',mapOut$sample, tableOut$sample,mapOrTable)
    
    groups = callModule(group_server,'group',mapOut$group,tableOut$group,mapOrTable)
    
    callModule(test_analysis_server, 'tana',groups)
    

})
