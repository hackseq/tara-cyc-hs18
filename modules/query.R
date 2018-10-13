query_ui = function(id){
    ns = NS(id)
    tagList(
        column(textInput("Sample", label = "sample"), 
               selectizeInput("Pathway type",
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
        column(checkboxGroupInput("Sample Type", label="Sample Type",
                                  choices = list("SINGLE"="SINGLE", "GOV"="GOV", "MULTI-GOV"="MULTI-GOV", "MULTI"="MULTI")), width = 2),
        column(checkboxGroupInput("Depth",label = "Depth", 
                           choices = list("DCM"="DCM",
                                          "SRF"="SRF",
                                          "MES"="MES",
                                          "MIX"="MIX",
                                          "MULTI"="MULTI")), width = 2),
        column(textInput("DepthSlider", label="DepthSlider"), width = 2),
        column(textInput("PWY Name", label = "PWY name"), width = 6),
        column(selectizeInput("Geo Region", label = "Geo Region",
                              choices = list("Atlantic Westerlies"="Atlantic Westerlies",
                                             "Indian Westerlies"= "Indian Westerlies",
                                             "Mediterranean Sea Westerlies"="Mediterranean Sea Westerlies",
                                             "Red Sea Coastal"="Red Sea Coastal",
                                             "Arabian Sea Coastal"="Arabian Sea Coastal",
                                             "Indian Coastal"="Indian Coastal",
                                             "Indian Trades"="Indian Trades",
                                             "Arabian Sea Coastal OMZ"="Arabian Sea Coastal OMZ",
                                             "Atlantic Coastal"="Atlantic Coastal",
                                             "Pacific Trades"="Pacific Trades",
                                             "Polar Polar"="Polar Polar",
                                             "Pacific Coastal"="Pacific Coastal",
                                             "Pacific Westerlies"="Pacific Westerlies",
                                             "MULTI"="MULTI"), multiple=TRUE),
               width = 6),
        column(sliderInput("RPKM", label= "RPKM", min = 0, max = 16000, value = c(0, 16000)), width = 12)
    )
}

query_server = function(input,output,session, query_table){
    
}