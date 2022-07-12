
load("df/data.RData")

library(ppsr)
library(correlationfunnel)
library(tidyverse)

# eda ---------------------------------------------------------------------

trust_ppsr_score <- df %>%
  score_predictors(y = "tp1", do_parallel = TRUE) %>%
  as_tibble()

df %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

d_bin <- df %>% drop_na() %>% binarize()

d_bin %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")


# auto-ML -----------------------------------------------------------------


