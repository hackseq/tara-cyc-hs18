welcome_ui = function(){
    tags$div(class = "welcomebox",
             #HTML('<center><img src = "tara_logo.png", height="240", width="240"></center>'),
             tags$h1('Viral Voyager'),
             HTML('<br><br>'),
             tags$p('TaraCyc is a website that shows a large-scale mapping of analysed metaviriome data collected from the Tara Oceans Project.'),
             tags$p('The Tara Oceans Project collected water samples data worldwide for shotgun metagenomic sequencing, this data is then mapped to metabolomic pathways.'),
             tags$p('Users can view, interact with, and analyse all the data in TaraCyc easily.')
             )}
