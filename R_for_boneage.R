library(ggplot2)
library(dplyr)
library(ragg)

# set this for making script directory as PATH
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

bone = read.csv("data/КВ.csv")

# this line if for scaling the displayed plot. You can play with "scaling"
# if you are not satisfied with the outcome
ragg::agg_jpeg("figures/bubble_plot.jpeg", 
               width = 1080, height = 1080, 
               units = "px", res = 300, scaling = 0.5)

# Most basic bubble plot
bone %>%
  arrange(desc(Count)) %>%
    mutate(Number = factor(Number, Number)) %>%
      ggplot(aes(x=Chronological.age, y=Bone.age, size=Count, fill=Sex)) +
      geom_point(alpha=0.5, shape=21, color="black") +
      theme_classic() + 
      scale_size(range = c(3, 13), breaks = c(1,4,9)) +
      ylab("Bone age (years)") +
      xlab("Chronological age (years)") +
      theme(legend.position = c(.98, 0.80),
            legend.justification = c("right", "top"),
            legend.box.just = "right",
            legend.margin = margin(3, 3, 3, 3),
            legend.background = element_rect(linetype = 2, 
                                             size = 0.5, 
                                             colour = 'black')) + 
      geom_abline(slope = 1, intercept = 0)

# save
dev.off()

