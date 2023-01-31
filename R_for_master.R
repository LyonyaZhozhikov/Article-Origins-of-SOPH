library(fmsb)
library(ragg)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

ragg::agg_jpeg("figures/radar_plot.jpeg", 
               width = 1920, height = 1080, units = "px", res = 300, scaling = 0.6)

par(mfrow=c(1,2), mar=c(3.5,1,5,1))

data <- read.csv("data/Radar_tabel_data_soph.csv")
samp2 <- data[,-1]
rownames(samp2) <- data[,1]

col_names <- c('Short \n stature',	'Senile \n skin','Underweight',	'Skull \n anomaly',	
               	'Fingers \n anomaly',	'Osteoporosis',	
               'Intellectual \n impairment',	'Muscular \n hypotonia', 'Brain MRI \n findings',
               'Seizures',	
              	'ALF',	'Elevated \n ALT/AST',	
               	'ID',	'Frequent \n infections',	'PH-anomaly',	
               	'Myopia',	'Color perception \n defect',	
               'Optic \n atrophy'
)

colors_in=c("#00BA38")
colors_fill=c("#00BA38")
radarchart(samp2,
           title = 'SOPH',
           axistype=1,
           seg=4,
           pcol=colors_in,
           pty=c(16,17),# форма точек экстремума
           pfcol=colors_fill,
           pdensity=30,
           pangle=c(45,135),
           plwd=2,# ширина линий
           plty=1, # тип линии
           cglcol="grey", 
           cglty=1, # тип линий между точками экстремума
           axislabcol="gray",
           cglwd=0.5,
           vlcex=0.8,
           caxislabels=c('','','50%','','100%'),
           calcex=0.8,
           vlabels=col_names
)

# c terminal
data <- read.csv("data/Radar_tabel_data_cterm.csv")
samp2 <- data[,-1]
rownames(samp2) <- data[,1]

colors_in=c("#93AA00")
colors_fill=c("#93AA00")
radarchart(samp2,
           title = 'C-terminal',
           axistype=1,
           seg=4,
           pcol=colors_in,
           pty=c(16,17),# форма точек экстремума
           pfcol=colors_fill,
           pdensity=30,
           pangle=c(45,135),
           plwd=2,# ширина линий
           plty=1, # тип линии
           cglcol="grey", 
           cglty=1, # тип линий между точками экстремума
           axislabcol="gray",
           cglwd=0.5,
           vlcex=0.8,
           caxislabels=c('','','50%','','100%'),
           calcex=0.8,
           vlabels=col_names
)

dev.off()

