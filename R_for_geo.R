library(ggplot2)
library(rworldmap)
library(ragg)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

ragg::agg_tiff("figures/geo_plot.tiff", 
               width = 1920, height = 1080, units = "px", res = 300)#

geo_data = read.csv('data/geo_heatmap_data.csv')
sPDF = joinCountryData2Map(geo_data,
                    joinCode = 'ISO3',
                    nameJoinColumn = 'ISO3',
                    verbose=TRUE)
par(mar=c(0,0,1,0))

# color
op <- palette(c('honeydew1','honeydew2','honeydew3','honeydew4'))


# whole
mapParams <- mapCountryData(sPDF, 
                            nameColumnToPlot="NBAS1",
                            mapTitle = 'Geographical origin of NBAS patients',
                            catMethod='categorical',
                            colourPalette='palette',
                            oceanCol = 'lightcyan',
                            # mapRegion = 'Eurasia',
                            missingCountryCol = 'white',
                            addLegend = FALSE
)

dev.off()

