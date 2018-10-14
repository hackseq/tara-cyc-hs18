welcome_ui = function(){
    tags$div(class = "welcomebox",
             tags$h1("Viral Voyager"),
             HTML('<br><br>'),
             tags$p('Viral Voyager is a website that shows a large-scale mapping of analysed metaviriome data collected from the Tara Oceans Project.'),
             tags$p('The Tara Oceans Project collected water samples data worldwide for shotgun metagenomic sequencing, and this data was then mapped to metabolomic pathways.'),
             tags$p('Users can play, explore, and download the genome dataset to gain understanding into the 
                    microscopic life living in Earths oceans.'),
             tags$p('299 size-fractioned water samples were collected from all over the worlds oceans. Viral and bacterial DNA
                    samples were extracted and sequenced. These sequences were then aligned with BLAST and 
                    and associated to a biological pathway that is likely to be regulated by each viral DNA sequence using MetaPathways v2.5, Pathway Tools and 
                    the MetaCyc hierarchy.
                    This was done with an algorithm developed by the Hallam lab at the University of British Columbia.'),
                    
             tags$p('Explore the interactive map of samples, some example summaries, or download the data!'),
             tags$p('Please contact us if you have any questions.'),
             tags$p('Steven Hallam email- shallam@mail.ubc.ca   phone- 604-827-3420.'),
             tags$p('Hackseq team leader: Arjun Baghela email: arjunsbaghela@gmail.com'),
             tags$p(tags$a(href="http://twitter.com/hallamlab?lang=en", "Hallam Lab on Twitter")),
             tags$p(tags$a(href="http://twitter.com/ecoscope_ubc?lang=en", "Ecoscope UBC on Twitter")),
             tags$p(tags$a(href="https://twitter.com/hackseq?lang=en", "Hackseq 2018 on Twitter"))
             
             )}
            
