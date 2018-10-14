team_ui = function(){
    tagList(
        fluidPage(theme = shinytheme("yeti"),
                  flowLayout(
                      wellPanel(img(src ="arjun.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$strong("Arjun Baghela"), 
                                
                                tags$br(), icon(name="twitter", class = NULL, lib = "font-awesome"), "@arjunsbaghela",
                                
                                tags$br(), icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/abaghela", "abaghela")
                                
                      ),
                      
                      
                      wellPanel(img(src ="ogan.jpg", width="150", height="150", style="border-radius:50%"),
                                p("B. Ogan Mancarci"),
                                icon(name = 'twitter',class = NULL, lib = 'font-awesome'),tags$a(href="https://twitter.com/OganM", "@oganm"),
                                br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/oganm", "oganm")
                      ),
                      
                      
                      wellPanel(img(src ="dan.jpg", width="150", height="150", style="border-radius:50%",  alt="Dan"),
                                tags$strong("Dan Fornika"),
                                tags$br(), icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/dfornika", "dfornika")
                      ),
                      
                      
                      
                      wellPanel(img(src ="kristen.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$b("Kristen Gray"), 
                                
                                tags$br(), icon(name="twitter", class = NULL, lib = "font-awesome"), "@agrayowl",
                                tags$br(), icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/klgray25", "klgray25") 
                      ),
                      
                      wellPanel(img(src ="Olga.jpg", width="130", height="150", style="border-radius:50%"),
                                tags$br(), tags$strong("Olga Solodova"), tags$br(""),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/ ", "??")
                      ),
                      
                      
                      wellPanel(img(src ="javier.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$strong("Javier J. Castillo Arnemann"), tags$br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/yavyx ", "yavyx")
                      ),
                      
                      wellPanel(img(src ="jasmine.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$strong("Jasmine Lai"),tags$br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/laijasmine", "laijasmine")
                      ),
                      
                      
                      wellPanel(img(src ="tony.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$strong("Tony Shen"), tags$br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/ ", " ??")
                      ),
                      
                      
                      wellPanel(img(src ="heather head shot.jpg", width="150", height="150", style="border-radius:50%"),
                                tags$strong("Heather Van Tassel"),tags$br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/heathervant", "heathervant")
                      ),
                      
                      wellPanel(img(src ="amyworkID_pic.jpg", width="120", height="150", style="border-radius:50%"),
                                tags$br(), tags$strong("Amy Zheng"), tags$br(),
                                icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/awlzhng", "awlzhng") 
                      ),
                      
                      
                      wellPanel(img(src ="kevin.JPG", width="150", height="150", style="border-radius:50%"), 
                                tags$strong("Kevin Lam"),
                                tags$br(),icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/KlamChowder1", "KlamChowder1") 
                      )
                  )
        )
    )
}