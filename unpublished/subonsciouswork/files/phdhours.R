phdhours <- read.csv("meetings/misc_files/phdhours.csv")
library(tidyverse)
phdhours$Week <- format(as.Date("2024-01-01") + seq(from=0, by=7, length.out=53))
plot_data <- phdhours |>
  mutate(ExtraWork = factor(Teaching-RA.Work, levels =c(-1,0,1), labels = c("RA", "None", "Teaching"))) |>
  select(Week, Weekly.total, ExtraWork) |>
  filter(Week < as.Date("2024-12-22"))

avg_hour <- mean(phdhours$Weekly.total)
arsa_submit <- phdhours$Week[40]
ggplot(plot_data, aes(Week, Weekly.total, colour=ExtraWork, group=1)) +
  geom_point() +
  geom_line(alpha=0.5) +
  geom_hline(yintercept = avg_hour) +
  geom_vline(xintercept = arsa_submit)

theme_minimal()

ggplot(plot_data, aes(ExtraWork, Weekly.total, colour=ExtraWork)) +
  geom_boxplot() +
  geom_jitter(alpha=0.5) +
  theme_minimal() +
  theme(legend.position="none")