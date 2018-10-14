analysis_ui = function(id){
    ns = NS(id)
    tagList(
        leafletOutput(ns("analysis"))
    )
}