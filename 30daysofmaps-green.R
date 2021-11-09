# monchrome
#install the osmdata, sf, tidyverse and ggmap package
if(!require("osmdata")) install.packages("osmdata")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("sf")) install.packages("sf")
if(!require("ggmap")) install.packages("ggmap")

#load packages
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)
#building the query
# L/B/R/T
e <- c(-16.875000,34.307144,37.968750,71.746432)


qc <- e %>%
  opq (timeout = 25*100) %>%
  add_osm_feature("shop", "charity")
q2h <- e %>%
  opq (timeout = 25*100) %>%
  add_osm_feature("shop", "second_hand")

#charity <- osmdata_sf(qc)
secondhand <- osmdata_sf(q2h)
#our background map
map <- get_map(e, source="stamen", 
               force = TRUE,zoom = 5, color="bw")

ggplot(charity$osm_points)+
  geom_sf(colour = "#238443",
          fill = "#004529",
          alpha = .5,
          size = 1,
          shape = 21)+
  geom_sf(data = secondhand$osm_points, colour="#bdbdbd", 
          fill="#f0f0f0", alpha=.5, size=.7, shape=21) +
  theme_void()
