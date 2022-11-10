
#load libraries ----
library(tidyverse)
library(ggforce)
library(tibble)
library(ggplot2)
theme_set(theme_void())

# Coordinates of equilateral triangle ----
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1)
)

# Method A ----

# Method B ----

# Method C ----