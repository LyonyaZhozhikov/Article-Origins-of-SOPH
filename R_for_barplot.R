library(tidyverse)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)
library(ggplot2)
library(ragg)

# set this for making script directory as PATH
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# picking data tables and specifying colons 
TP <- read.csv("data/barplot_data.csv", header = TRUE) %>%
  select(trait, abs, perc, total_norm, total, perc_total, color_rgb) %>%
  rename(Absolute = abs, Percent = perc)

# for better representation I cut the left side of the bar by dividing to 4
TP <- mutate(TP, Absolute = -Absolute/4)
TP <- mutate(TP, total = -total/4)

# saves the order as in data frame
TP$trait <- factor(TP$trait, levels = TP$trait)

# this line if for scaling the displayed plot. You can play with "scaling"
# if you are not satisfied with the outcome
ragg::agg_jpeg("figures/barplot.jpeg", 
              width = 2480, height = 2631, units = "px", res = 300, scaling = 0.32)

# plot
ggplot(TP, aes(x = trait)) +
  geom_col(aes(y = perc_total, fill = factor(color_rgb)), alpha = 0.1) +
  scale_fill_manual(values = c("#0099ff", "#ffd700", "#0099ff", "#ffd700", # golden of Ukrainian flag
                                        "#0099ff", "#ffd700","#0099ff", "#ffd700", # blue of Yakutian flag
                                        "#0099ff", "#ffd700","#0099ff")) +
  geom_col(aes(y = total), fill = "#ebe8e6") +
  
  geom_col(aes(y = Percent), fill = "#5d8402") +
  geom_text(aes(y = ifelse(Percent >= 50, Percent-4, Percent+4)), 
            color = ifelse(TP$Percent >= 50, 'white', '#5d8402'), 
            label = TP$Percent, 
            size = 8)+
  
  geom_col(aes(y = Absolute), fill = "#817d79") +
  geom_text(aes(y = ifelse(Absolute <= -12.5, Absolute+4, Absolute-4)), 
            color = ifelse(TP$Absolute <= -12.5, 'white', '#817d79'), 
            label = TP$total_norm, 
            size = 8)+
  
  geom_text(aes(y = -55, label = trait), hjust = 0, size = 10) +
  scale_x_discrete(limits = rev(levels(TP$trait))) +
  coord_flip()  + 
  theme_void()  +
  theme(legend.position="none")
  
dev.off() #nowar

