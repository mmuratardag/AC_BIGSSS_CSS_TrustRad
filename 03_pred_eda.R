
## to be aupdated/Ccleaned

load("df/data_feat_eng.RData")
library(ppsr)
library(correlationfunnel)
library(tidyverse)

trust_ppsr_score <- d %>%
  select(-session_id) %>%
  score_predictors(y = "tp1", do_parallel = TRUE) %>%
  as_tibble()

d %>% select(-session_id) %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


d_bin <- d %>% select(-session_id) %>%
  binarize()

d_bin %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")
