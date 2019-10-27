## Source all files with the R functions
file.sources = list.files("./Functions",full.names = T)
sapply(file.sources,source,.GlobalEnv)

library(shinydashboard)

shinyUI( 
  
  dashboardPage(skin = "black",
                dashboardHeader(title = "PMX Solutions - Population PK simulator",titleWidth = 450,
                                tags$li(a(href = 'http://www.PMXSolutions.com',
                                          img(src = 'Logo.png',
                                              title = "PMX Solutions", height = "50px"),
                                          style = "padding-top:0px; padding-bottom:0px;"),
                                        class = "dropdown")),
  
  
  

  # Specify the sidebar menu items
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Model selection", tabName = "model", icon = icon("folder")),
      menuItem("Simulation details", tabName = "siminfo", icon = icon("file-invoice")),
      menuItem("Simulation output", tabName = "output", icon = icon("chart-area")),
      actionButton("do", "Start simulation",icon = icon("paper-plane"),style='background-color: #FF9933; ' ),
      
      hr(),
      menuItem("Report generation", tabName = "report", icon = icon("book"))
      
    )
  ),
  
  
  
  # body of the app
  dashboardBody(
    tabItems(
      tabItem(tabName = "model",UImodel()),
      tabItem(tabName = "siminfo",UIsiminfo()),
      tabItem(tabName = "output",UIoutput()),
      tabItem(tabName = "report",UIreport())
      
    )
  )
))