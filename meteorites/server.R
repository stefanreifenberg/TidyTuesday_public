library(shiny)
library(leaflet)
server <- function(input, output, session) {
  meteorites <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-11/meteorites.csv")
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      setView(lat = 10, lng = 0, zoom = 2) %>% 
      addProviderTiles("CartoDB.DarkMatter") %>% 
      addCircleMarkers(meteorites$long, meteorites$lat, 
                       label = meteorites$name,
                       layerId = meteorites$name,
                       popup = meteorites$name, meteorites$mass,
                       popupOptions = (keepInView = TRUE),
                       radius = 7,
                       stroke = TRUE,
                       fillOpacity = 1,
                       clusterOptions = markerClusterOptions(showCoverageOnHover = FALSE))
  })
  
  observe(
    { click=input$mymap_marker_click
    sub = meteorites[meteorites$name==input$mymap_marker_click$id, c("name","mass","year","geolocation")]
    print(sub)
    mass = sub$mass
    year = sub$year
    geo = sub$geolocation
    nm=sub$name
    if(is.null(click))
      return()
    else
      output$text <- renderUI({
        HTML(paste0("Name: ", nm,br(),
                    "Year: ", year,br(),
                    "Mass (gr): ", mass,br(),
                    "Location: ", geo)
        )})
    
    }
  )
  
  
}