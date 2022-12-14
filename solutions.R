
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

# Method A (Two Random Endpoints)----
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

# Finding Number of Successful Outcomes
sum = 0

for (i in 1:n)
  sum = sum + l[[i]]

# Finding Probabilty
prob = sum / n
prob

# Method B (Random Radius and Point)----

n = 1000 # number of trials
l = c() # create an empty matrix

# Coordinates of random radius

for (i in 1:n){
  rdmrad_df <- tibble(
    x    = 0,
    y    = 0,
    xend = runif(1, min = -1, max=1),
    yend = sample(c(sqrt(1 - (xend)^2), -sqrt(1 - (xend)^2)), 1)
  )
  
  xend = rdmrad_df[3]
  yend = rdmrad_df[4]
  a = runif(1)
  
  rdmpnt_df <- tibble(
    x = a * xend,
    y = a * yend
  )
  
  # Plot
  
  ggplot() +
    ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
    geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_segment(data = rdmrad_df, aes(x = x, y = y, xend = xend, yend = yend),
                 col = "red3") +
    coord_equal()
  
  # Finding length of chord
  # Assigning chords 0's or 1's
  # 0 -shorter
  # 1 - longer
  
  x = rdmpnt_df[1]
  y = rdmpnt_df[2]
  l[i] = floor(2 * sqrt(1 - x ^ 2 - y ^ 2) / sqrt(3))
}

# Finding number of succesful outcomes
sum = 0

for (i in 1:n)
  sum = sum + l[[i]]

# Finding probability
prob = sum / n

prob

# Method C (Random Midpoint) ----

n = 1000 # number of trials
l = c() # create an empty matrix
#
for (i in 1:n){
  
  # Coordinates of random midpoint
  r = sqrt(runif(1))
  theta = 2 * pi * runif(1)
  rdmpnt_df <- tibble(
    x    = r * cos(theta),
    y    = r * sin(theta),
  )
  
  # Finding length or chord
  x = rdmpnt_df[1]
  y = rdmpnt_df[2]
  
  length = 2 * sqrt(1 - x ^ 2 - y ^ 2)
  
  # Assigning chords 0's or 1's
  # 0 -shorter
  # 1 - longer
  l[i] = floor(length / sqrt(3))
}

# Finding number of succesful outcomes
sum = 0

for (i in 1:n)
  sum = sum + l[[i]]

# Finding probability
prob = sum / n
prob