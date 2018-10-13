welcome_ui = function(){
    tags$div(class = "welcomebox",
             tags$h1('Tara Ocean Virome Hallum Lab'),
             tags$h1('Metapathways Tool'),
             HTML('<br><br>'),
             tags$p('TaraCyc is a website that shows a large-scale mapping of analysed metaviriome data collected from the Tara Oceans Project.'),
             tags$p('The Tara Oceans Project collected water samples data worldwide for shotgun metagenomic sequencing, this data is then mapped to metabolomic pathways.'),
             tags$p('Users can view, interact with, and analyse all the data in TaraCyc easily.'))
    
}