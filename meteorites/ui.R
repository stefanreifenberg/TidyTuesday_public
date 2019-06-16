library(shiny)
library(leaflet)
ui <- bootstrapPage(
  tags$style(type = "text/css", "html,
             body {width:100%;height:100%}"),
  leafletOutput("mymap", width = "100%", height = "100%"),
  absolutePanel(top=10, right=10, fixed=TRUE,
                tags$div(style = "opacity: 0.7; background: #FFFFEE; padding: 8px; ",
                         helpText("Each marker represents a meteor strike.", br(),
                                   "Click for additional information"),
                         uiOutput("text"))))
