query_ui = function(id){
    ns = NS(id)
    tagList(
        actionButton(ns('debugButton'), 'pressme'),
        column(textInput(ns("SAMPLE"), label = "Sample"), 
               selectizeInput(ns("LEVEL1"),
                              label = "Pathway Type", 
                              choices = list("Biosynthesis"="Biosynthesis",
                                             "Energy-Metabolism"="Energy-Metabolism",
                                             "Degradation"="Degradation",
                                             "Detoxification"="Detoxification",
                                             "Macromolecule Modification"="Macromolecule Modification",
                                             "Activation-Inactivation-Interconversion"= "Activation-Inactivation-Interconversion",
                                             "Generation of Precursor Metabolites and Energy"= "Generation of Precursor Metabolites and Energy",
                                             "Super-Pathways"="Super-Pathways",
                                             "Metabolic-Clusters"="Metabolic-Clusters"), multiple=TRUE),
               width = 6),
        column(checkboxGroupInput(ns("TYPE"), label="Sample Type",
                                  choices = list("SINGLE"="SINGLE", "GOV"="GOV", "MULTI-GOV"="MULTI-GOV", "MULTI"="MULTI")), width = 2),
        column(checkboxGroupInput(ns("DEPTH"),label = "Depth", 
                                  choices = list("DCM"="DCM",
                                                 "SRF"="SRF",
                                                 "MES"="MES",
                                                 "MIX"="MIX",
                                                 "MULTI"="MULTI")), width = 2),
        column(textInput(ns("DEPTHSlider"), label="DepthSlider"), width = 2),
        column(textInput(ns("PWY_NAME"), label = "Pathway Name"), width = 6),
        column(selectizeInput(ns("GEOREGION"), label = "Geo Region",
                              choices = list("Atlantic Westerlies"="Atlantic_Westerlies",
                                             "Indian Westerlies"= "Indian_Westerlies",
                                             "Mediterranean Sea Westerlies"="MedSea_Westerlies",
                                             "Red Sea Coastal"="RedSea_Coastal",
                                             "Arabian Sea Coastal"="ArabSea_Coastal",
                                             "Indian Coastal"="Indian_Coastal",
                                             "Indian Trades"="Indian Trades",
                                             "Arabian Sea Coastal OMZ"="ArabSea_Coastal_OMZ",
                                             "Atlantic Coastal"="Atlantic_Coastal",
                                             "Pacific Trades"="Pacific_Trades",
                                             "Polar Polar"="Polar_Polar",
                                             "Pacific Coastal"="Pacific_Coastal",
                                             "Pacific Westerlies"="Pacific_Westerlies",
                                             "MULTI"="MULTI"), multiple=TRUE),
               width = 6),
        column(sliderInput(ns("RPKM"), label= "RPKM", min = 0, max = 16000, value = c(0, 16000)), width = 12)
    )
}

query_server = function(input,output,session, query_table){
    observe({
        #Ωbrowser()
        filtered_df <- query_table()
        if (!is.null(input$TYPE) & input$TYPE != "") {
            filtered_df <- filter(filtered_df, TYPE%in%(input$TYPE))
        }
        if (!is.null(input$DEPTH)) {
            filtered_df <- filter(filtered_df, DEPTH%in%(input$DEPTH))
        }
        if (!is.null(input$PWY_NAME) & input$PWY_NAME != "") {
            filtered_df <- filter(filtered_df, PWY_NAME%in%(input$PWY_NAME))
        }
        if (!is.null(input$RPKM)) {
            filtered_df <- filter(filtered_df, RPKM <= max(input$RPKM) & RPKM >= min(input$RPKM))
        }
        if (!is.null(input$SAMPLE) & input$SAMPLE != "") {
            filtered_df <- filter(filtered_df, SAMPLE%in%(input$SAMPLE))
        }
        if (!is.null(input$GEOREGION) & input$GEOREGION != "") {
            filtered_df <- filter(filtered_df, GEOREGION%in%(input$GEOREGION))
        }
        if (!is.null(input$DEPTHSlider)) {
            filtered_df <- filter(filtered_df, DEPTH <= max(input$DEPTHSlider) & DEPTH >= min(input$DEPTHSlider))
        }
        query_table(filtered_df)
    })
    
}
