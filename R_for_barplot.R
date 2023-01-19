library(tidyverse)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)
library(ggplot2)
library(showtext)

# font_add("times", regular = "times.ttf", bold = "timesbd.ttf")
font_add("Times New Roman", "times.ttf")
showtext_auto()

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

TP <- read.csv("data/barplot_data.csv", header = TRUE) %>%
  select(trait, abs, perc, abs_norm, total_norm, total, perc_total) %>%
  rename(Absolute = abs, Percent = perc)

TP <- mutate(TP, Absolute = -Absolute)
TP <- mutate(TP, total = -total)

# saves the order as in dataframe
TP$trait <- factor(TP$trait, levels = TP$trait)

ggplot(TP, aes(x = trait)) +
  geom_col(aes(y = total), fill = "#ebe8e6") +
  geom_col(aes(y = perc_total), fill = "#eaf5d0") +
  
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
  theme_void()

ggsave('figures/master_table.jpeg',
       width = 2480, height = 2631, units = "px", dpi = "print")
