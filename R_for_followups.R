library(ggplot2)
library(dplyr)
library(viridis)
library(hrbrthemes)
library(ragg)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

f_follow = read.csv("data/follow up soph first.csv")
l_follow = read.csv("data/follow up soph last.csv")

ragg::agg_jpeg("figures/followup_plot.jpeg", 
               width = 1080, height = 720, 
               units = "px", res = 300, scaling = 0.5)

# dodge version
f_follow$Observation <- "First follow up"
l_follow$Observation <- "Last follow up"
d <- rbind(f_follow, l_follow)
ggplot(d, aes(Age, Patients, fill = Observation)) +
  theme_classic() +
  geom_bar(stat='identity', position = "dodge") +
  ylab("Patients (number)") + 
  xlab("Age (years)") +
  theme(legend.title=element_blank(),
        legend.position = c(.98, 0.80),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(3, 3, 3, 3))

dev.off()

