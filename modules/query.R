query_ui = function(id){
    ns = NS(id)
    tagList()
    
    fluidPage(
        sidebarLayout(
            sidebarPanel(
                checkboxGroupInput("Depth",
                                   label = "Depth", 
                                   choices = list("DCM"="DCM",
                                                  "SRF"="SRF",
                                                  "MES"="MES",
                                                  "MIX"="MIX",
                                                  "MULTI"="MULTI")),
                textInput("PWY Name", label = "PWY name"),
                textInput("Sample", label = "sample"),
                sliderInput("RPKM", label= "RPKM", min = 0, max = 16000, value = c(0, 16000)),
                checkboxGroupInput("Pathway type",
                                   label = "Pathway Type", 
                                   choices = list("Biosynthesis"="Biosynthesis",
                                                  "Energy-Metabolism"="Energy-Metabolism",
                                                  "Degradation"="Degradation",
                                                  "Detoxification"="Detoxification",
                                                  "Macromolecule Modification"="Macromolecule Modification",
                                                  "Activation-Inactivation-Interconversion"= "Activation-Inactivation-Interconversion",
                                                  "Generation of Precursor Metabolites and Energy"= "Generation of Precursor Metabolites and Energy",
                                                  "Super-Pathways"="Super-Pathways",
                                                  "Metabolic-Clusters"="Metabolic-Clusters")),
                checkboxGroupInput("Sample Type", label="Sample Type",
                                   choices = list("SINGLE"="SINGLE", "GOV"="GOV", "MULTI-GOV"="MULTI-GOV", "MULTI"="MULTI")),
                checkboxGroupInput("Geo Region", label = "Geo Region",
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
                                                  "MULTI"="MULTI"))
            )
        )
    )
}

query_server = function(input,output,session, query_table){
    
}