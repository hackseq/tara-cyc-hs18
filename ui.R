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

ui <- dashboardPage(
    dashboardHeader(title = "TaraCyc Viral Voyager"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Welcome", tabName = "welcome", icon = icon("home")),
            menuItem("Map", tabName = "map", icon = icon("globe")),
            menuItem("Analysis", tabName = "analysis", icon = icon("flask"))
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName="welcome"),
            
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
                        map_ui('map')
                    )
                ),
                fluidRow(
                    box(
                        title="Sample Information", width = 12, solidHeader = TRUE,
                        sample_ui('sample')
                    )
                )
            ),
            
            tabItem(tabName="analysis")
        )
    )
)
