#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinythemes)



ui <- dashboardPage(
    dashboardHeader(tags$li(img(src = 'tara_logo.png',
                                  title = "Company Home", height = "30px"),
                              style = "padding-top:10px; padding-bottom:10px;", class="dropdown"),
                            title = "Viral Voyager"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Welcome", tabName = "welcome", icon = icon("home")),
            menuItem("Map", tabName = "map", icon = icon("globe")),
            menuItem("Analysis", tabName = "analysis", icon = icon("flask")),
            menuItem("Future Directions", tabName = "futuredirections", icon = icon("arrow-circle-right")),
            menuItem("Team Members", tabName = "members", icon = icon("user-circle-o")),
            group_ui('group')
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName="welcome",
                    HTML('<center><img src = "tara_logo.png", height="240", width="240"></center>'),
                    welcome_ui()),
                    
                    
            tabItem(tabName="map",
                h1('Map of Viral Metabolic Pathways'),
                fluidRow(
                    box(
                        title="Controls", width = 12, solidHeader = TRUE,
                        query_ui('query')
                    )
                ),
                fluidRow(
                    box(
                        width = 12, solidHeader = TRUE,
                        tabsetPanel(id = 'map_or_table',
                            tabPanel('Map View',
                                     value = 'map',
                                     map_ui('map')),
                            tabPanel('Table View',
                                     value = 'table',
                                     table_ui('table'))
                        )
                        
                    )
                ),
                fluidRow(
                    box(
                        title="Sample Information", width = 12, solidHeader = TRUE,
                        sample_ui('sample')
                    )
                )
            ),
            
            tabItem(tabName="analysis",
                    tabsetPanel(
                        tabPanel('Heatmap',
                                 test_analysis_ui('tana')),
                        tabPanel('Clustering',
                                 clustering_ui('clustering'))
                    )),
            
            tabItem(tabName="futuredirections",
                    h5 ('Future Directions'),
                    img(src = "tara_logo.png", height="80", width="80", align="middle")),
                        
    
            
            tabItem(tabName="members", h1('Meet the Team'), 
                    fluidPage(theme = shinytheme("yeti"),
                        flowLayout(
                            
                            
                            wellPanel(img(src ="arjun.jpg", width="150", height="150", style="border-radius:50%"),
                                      tags$strong("Arjun Baghela"), 
                                      
                                      tags$br(), icon(name="twitter", class = NULL, lib = "font-awesome"), "@arjunsbaghela",
                                      
                                      tags$br(), icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/abaghela", "abaghela")
                                      
                            ),
                            
                            
                            wellPanel(img(src ="ogan.jpg", width="150", height="150", style="border-radius:50%"),
                                      tags$strong("Burak Ogan Mancarci"),
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
                                      icon(name="github", class = NULL, lib = "font-awesome"), tags$a(href="https://github.com/solodova", "solodova")
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
                        
                        
                        #titlePanel("example"),
               
                       #load.image(https://hackseq18.slack.com/files/UD6SDLFNH/FDD10G6M6/image_from_ios.jpg),
                    
            
        
                       
                        
                        )
                        
                    )
                    
            )
                    
            
                     
            
            
        
        )
    )
)
