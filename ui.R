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

# Define UI for application that draws a histogram
dashboardPage(
  #Top bar
  dashboardHeader(),
  
  dashboardSidebar(),
  
  dashboardBody(
      # Application title
      titlePanel("Tara-Cyc"),
      query_ui('query'),
      map_ui('map')
  )

)

ui <- dashboardPage(
    dashboardHeader(title = "TaraCyc"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Welcome", tabName = "welcome", icon = icon("home")),
            menuItem("Map", tabName = "map", icon = icon("globe")),
            menuItem("Analysis", tabName = "analysis", icon = icon("flask"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName="welcome"),
            
            tabItem(tabName="map",
                h1('Map of Viral Metabolic Pathways'),
                fluidRow(query_ui('query')),
                fluidRow(
                    box(
                        title="Controls", width = 12, status = "primary"
                    )
                ),
                fluidRow(
                    box(
                        width = 12, status = "primary",
                        map_ui('map')
                    )
                ),
                fluidRow(
                    box(
                        width = 12,
                        sample_ui('sample')
                    )
                )
            ),
            
            tabItem(tabName="analysis")
        )
    )
)
