library(tidyverse)
library(plotly)

# tidy tuesday week 25
# custom plotly text on hover = hovertemplate

bird_counts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-18/bird_counts.csv")
 
sum_species <- bird_counts %>% 
  group_by(species) %>% 
  summarise(how_many_counted = sum(how_many_counted)) %>% 
  filter(rank(desc(how_many_counted))<=10) # get only top 10

# plotly graph

a <- sum_species %>% 
  plot_ly(
  x = ~species,
  y = ~how_many_counted,
  type = "bar",
  text = ~species,
  hovertemplate = paste(
    "<b>%{text}</b><br><br>",
    "%{yaxis.title.text}: %{y:.0f}<br>",
    "<extra></extra>"
  )
)
a

