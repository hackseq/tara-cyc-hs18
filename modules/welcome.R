welcome_ui = function(){
    tags$div(class = "welcomebox",
             tags$h1("Viral Voyager"),
             HTML('<br><br>'),
             tags$p(
                 tags$h3('Viral Voyager is a website that shows a large-scale mapping of analysed 
                         metaviriome data collected from the Tara Oceans Project.'),
                 tags$h5(
                     tags$a(href="http://ocean-microbiome.embl.de/companion.html", "Tara Oceans website"))),
             
             tags$p(
                 tags$h3('The Tara Oceans Project collected water samples data worldwide for 
                         shotgun metagenomic sequencing, and this data was then mapped to 
                         metabolomic pathways.')),
             tags$p(
                tags$h3('Users can play, explore, and download the genome dataset to gain understanding
                        into the 
                    microscopic life living in Earths oceans. Explore the interactive map of samples, 
                     some example summaries, or 
                        download the data!')),
             tags$p(
                tags$h4('299 size-fractioned water samples were collected. Viral and bacterial DNA
                    sequences were then aligned with BLAST and 
                    and associated to a biological pathway that is likely to be regulated by each viral DNA sequence using MetaPathways v2.5, Pathway Tools and 
                    the MetaCyc hierarchy. This dataset currently has 1050 different pathways that fall into 61 subcategories, which can be further organized into 
                    nine categories:'),
                tags$ol(
                tags$li("Biosynthesis"),
                tags$li("Energy-Metabolism"),
                tags$li("Degradation"),
                tags$li("Detoxification"),
                tags$li(" Macromolecule Modification"),         
                tags$li("Activation-Inactivation-Interconversion"),
                tags$li("Generation of Precursor Metabolites and Energy"),
                tags$li("Super-Pathways"),
                tags$li("Metabolic-Clusters"))),
            # tags$p(
             #   tags$h4('This was done with an algorithm developed by the Hallam lab at the University 
              #      of British Columbia. The Viral Voyager hackseq team from UBC\'s 2018 hackathon made
              #     this data publically accessible and developed functionality tools for exploring 
              #      the data.')),
             tags$p('Please contact us if you have any questions.'),
             tags$p('Steven Hallam email: shallam@mail.ubc.ca   phone: 604-827-3420.'),
             tags$p('Hackseq team leader: Arjun Baghela email: arjunsbaghela@gmail.com'),
             tags$p(
                 tags$a(href="http://twitter.com/hallamlab?lang=en", "Hallam Lab on Twitter"),
                 icon(name="twitter", class = NULL, lib = "font-awesome")),
                 
             tags$p(tags$a(href="http://twitter.com/ecoscope_ubc?lang=en", "Ecoscope UBC"),
                    icon(name="twitter", class = NULL, lib = "font-awesome")),
             tags$p(tags$a(href="https://twitter.com/hackseq?lang=en", "Hackseq 2018"),
                    icon(name="twitter", class = NULL, lib = "font-awesome"))
             
             )}
            
