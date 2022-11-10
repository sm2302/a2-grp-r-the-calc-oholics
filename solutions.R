
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
n = 1000
l = c()

for (i in 1:n){
  # Coordinates of random chord
  rdmchr_df <- tibble(
    x    = runif(1, min = -1, max=1),
    y    = sample(c(sqrt(1 - x^2), -sqrt(1 - x^2)), 1),
    xend = runif(1, min = -1, max=1),
    yend = sample(c(sqrt(1 - (xend)^2), -sqrt(1 - (xend)^2)), 1)
  )
  
  # Draw a random chord in a unit circle centred at origin
  # Plot
  ggplot() +
    ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
    geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_segment(data = rdmchr_df, aes(x = x, y = y, xend = xend, yend = yend),
                 col = "red3") +
    coord_equal()
  
  # Finding length of random chord
  x = rdmchr_df[1]
  y = rdmchr_df[2]
  xend = rdmchr_df[3]
  yend = rdmchr_df[4]
  
  l[i] = floor(sqrt((x - xend) ^ 2 + (y-yend) ^ 2) / sqrt(3))
  # 0 - shorter
  # 1 - longer
}

# Finding Number of Longer Length
sum = 0

for (i in 1:n)
  sum = sum + l[[i]]

# Finding Probabilty
prob = sum / n
prob

# Method B ----

# Method C ----