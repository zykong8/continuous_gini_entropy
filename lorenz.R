# ENV
rm(list = ls())
gc()


# library
library(openxlsx)
library(ggplot2)
library(tidydr)

getOption("encoding")
options(encoding = "UTF-8")

df <- read.xlsx("Lorenz_Curve.xlsx", colNames=TRUE, rowNames = FALSE)

p1 <- ggplot(data = df) +
  stat_smooth(aes(x = xRatio, y = yRatio), method = "loess", se = FALSE, color = "black") +
  stat_smooth(aes(x = xRatio, y = xRatio), method = "loess", se = FALSE, color = "green")
p1  

# Convert ggplot-plot object for rendering 
ptxt <- ggplot_build(p1)

# Extract data for the loess lines from the 'data' slot
df2 <- data.frame(
  x = ptxt$data[[1]]$x,
  ymin = ptxt$data[[1]]$y,
  ymax = ptxt$data[[2]]$y,
  yzero = rep(0, length(ptxt$data[[1]]$y))
)

# Using the loess data to add the 'ribbon' to plot 
p2 <- p1 + geom_ribbon(
    data = df2, 
    aes(x = x, ymin = ymin, ymax = ymax), 
    fill = "blue", 
    alpha = 0.4
  ) + 
  geom_ribbon(
    data = df2, 
    aes(x = x, ymin = yzero, ymax = ymin), 
    fill = "red", 
    alpha = 0.4
  ) + 
  theme_dr()
p2

# Annotation
p3 <- p2 + annotate(
  geom = "text",
  x = c(0.7, 0.8),
  y = c(0.6, 0.3),
  label = c("A", "B"),
  size = 8
) +
  annotate(
    geom = "text",
    x = 0.2,
    y = 0.8,
    parse=TRUE,
    label = "Gini==frac(A, A+B)",
    size = 8,
    hjust = 0.5,
    vjust = 0.5
  ) +
  annotate(
    geom = "text",
    x = 0.5,
    y = 0.55,
    label = "Absolute equal distribution line",
    angle = 45
  ) +
  annotate(
    geom = "text",
    x = 0.5,
    y = 0.2,
    label = "Actual distribution line",
    angle = 36
  )
  
p3


# geom-text-path
library(geomtextpath)
p4 <- ggplot(data = df) +
  stat_smooth(aes(x = xRatio, y = yRatio), method = "loess", se = FALSE, color = "black") +
  stat_smooth(aes(x = xRatio, y = xRatio), method = "loess", se = FALSE, color = "green")
p4

p5 <- ggplot(data = df) +
  geom_labelsmooth(
    aes(x = xRatio, y = yRatio, label = "Actual distribution line"), 
    text_smoothing = 30, 
    fill = "#F6F6FF", # label背景色
    method = "loess", 
    formula = y ~ x,
    size = 4, linewidth = 1, 
    boxlinewidth = 0.3
  ) +
  geom_labelsmooth(
    aes(x = xRatio, y = xRatio, label = "Absolute equal distribution line"), 
    text_smoothing = 30, color = "green",
    textcolour = "black",
    fill = "#F6F6FF", # label背景色
    method = "loess", 
    formula = y ~ x,
    size = 4, linewidth = 1, 
    boxlinewidth = 0.3
  ) +
  geom_ribbon(
    data = df2, 
    aes(x = x, ymin = ymin, ymax = ymax), 
    fill = "blue", 
    alpha = 0.4
  ) +
  geom_ribbon(
    data = df2, 
    aes(x = x, ymin = yzero, ymax = ymin), 
    fill = "red", 
    alpha = 0.4
  ) + 
  theme_dr()
p5

p6 <- p5 + annotate(
  geom = "text",
  x = c(0.7, 0.8),
  y = c(0.6, 0.3),
  label = c("A", "B"),
  size = 8
) +
  annotate(
    geom = "text",
    x = 0.2,
    y = 0.8,
    parse=TRUE,
    label = "Gini==frac(A, A+B)",
    size = 8,
    hjust = 0.5,
    vjust = 0.5
  )
p6
ggsave(filename = "Lorenz.png", height = 7, width = 7, plot = p6)








