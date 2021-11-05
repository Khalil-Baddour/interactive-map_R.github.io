# Charger librairies (il faut les installer puis les charger)
  ## pour installer :  install.packages("leaflet")
library(maptools)
library(rgeos)
library(rgdal)
library(sp)
library(RColorBrewer)
display.brewer.all()
library(leaflet)
library(cartography)
library(sf)
library(lwgeom)
library(data.table)
library(dplyr)
library(ggpubr)
library(grid)
library(htmlwidgets)
library(devtools)
# Importer ma couche shp (fond de ma carte) 

getwd()   # pour savoir le chemin de mon projet R
departements = readOGR(dsn = "D:/chemin_du_dossier/data", layer = "departem_promethe2")
View(departements)

# Définir la légende de ma carte

bins <-c(734, 5000, 10000, 15000, 20000, 21713)
qpal = colorBin("Reds", departements$Nb_feux, bins=bins)


# Spécifier le label à représenter dans ma couche

labels <- sprintf(
  "<strong>%s</strong>",
  departements$Nb_feux
) %>% lapply(htmltools::HTML)


# Visualisation interactive de ma carte avec leaflet

leaflet(departements) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE,opacity = 1,fillOpacity = 0.5, smoothFactor = 0.5,
              color="black",fillColor = ~qpal(Nb_feux),weight = 1, label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>%
  addLegend(values=~Nb_feux,pal=qpal,title="Nombre d'incendies de forêt")

