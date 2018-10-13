query_ui = function(id){
    ns = NS(id)
    tagList()
    
    checkboxGroupInput("Depth",label = "Depth", 
                choices = list("DCM"="DCM",
                                "SRF"="SRF",
                                "MES"="MES",
                                "MIX"="MIX",
                                "MULTI"="MULTI"))
}

query_server = function(input,output,session, query_table){
    
}