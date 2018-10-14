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
#library("leaflet")

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
                    #img(src = "tara_logo.png", height="80", width="80", align="middle")),
                    
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
                        tabPanel('Test Analysis',
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
                            p("Arjun Baghela "),
                            icon(name="twitter", class = NULL, lib = "font-awesome"), p("Arjun's twitter"),
                            
                            icon(name="github", class = NULL, lib = "font-awesome"), p("abaghela")
                        ),
                        
                        
                        
                        wellPanel(img(src ="dan.jpg", width="150", height="150", style="border-radius:50%",  alt="Dan")
                        ),
                        
                        
  
                        wellPanel(img(src ="kristen.jpg", width="150", height="150", style="border-radius:50%"),
                        p("Kristen Grey"),
                        
                        icon(name="twitter", class = NULL, lib = "font-awesome"), p("@agrayowl"),
                        
                        icon(name="github", class = NULL, lib = "font-awesome"), p("klgray25")
                        ),
                        
                        wellPanel(img(src ="jasmine.jpg", width="150", height="150", style="border-radius:50%"),
                                  p("Jasmine Lai"),
                            icon(name="github", class = NULL, lib = "font-awesome"), p("laijasmine")
                        ),
                        
                        
                        wellPanel(img(src ="tony.jpg", width="150", height="150", style="border-radius:50%"),
                                  p("Tony Shen"),
                                  icon(name="github", class = NULL, lib = "font-awesome"), p("Tony's git")
                        ),
                        
                        
                        wellPanel(img(src ="heather head shot.jpg", width="150", height="150", style="border-radius:50%")
                                  
                        ),
                        
                        
                        
                        #titlePanel("example"),
                        wellPanel("example"),
                       #load.image(https://hackseq18.slack.com/files/UD6SDLFNH/FDD10G6M6/image_from_ios.jpg),
                       wellPanel("example"),
            
            
                       wellPanel("example")
                       
                        
                        )
                        
                    )
                    
            )
                    
            
                     
            
            
        
        )
    )
)
