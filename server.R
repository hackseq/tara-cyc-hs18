
shinyServer(function(input, output,session) {

    query_table = reactiveVal(tara_data)

    callModule(query_server,'query',tara_data,query_table)

    mapOut =  callModule(map_server,'map', query_table)

    callModule(sample_server,'sample',mapOut$outSample)
    
    callModule(group_server,'group',mapOut$outGroup)

})
