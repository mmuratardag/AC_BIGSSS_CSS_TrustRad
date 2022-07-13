
load("df/data_complete_obs.RData")

library(ppsr)
library(correlationfunnel)
library(tidyverse)

d_miss %>% skimr::skim()

d_miss <- d_miss %>% mutate(
  age_cat = case_when(age <= 44 ~ "young",
                      age > 44 & age <= 65 ~ "midage",
                      age >= 65 ~ "old") 
)

d_miss$age_cat <- factor(d_miss$age_cat)

d_miss %>% skimr::skim()

# eda socio-dem -----------------------------------------------------------

d_miss %>% select(tp1, age_cat, gender:religiosity) %>% 
  visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

d_miss %>% select(tp1, age_cat, gender:religiosity) %>% 
  binarize() %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")


# auto-ml -----------------------------------------------------------------

aml_df_sd <- d_miss %>% select(tp1, age_cat, gender:religiosity)
library(h2o)
h2o.init(nthreads = -1, max_mem_size = "24G")
aml_df_sd <- as.h2o(aml_df_sd)
h2o.describe(aml_df_sd)
y <- "tp1"
splits <- h2o.splitFrame(aml_df_sd, ratios = 0.8, seed = 123)
train <- splits[[1]]
test <- splits[[2]]
aml <- h2o.automl(y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 900,
                  seed = 321,
                  project_name = "SocDemPredGT_noMiss")
print(aml@leaderboard)
model_ids <- as.data.frame(aml@leaderboard$model_id)[,1]
se <- h2o.getModel(grep("StackedEnsemble_AllModels", model_ids, value = TRUE)[1])
metalearner <- h2o.getModel(se@model$metalearner$name)
metalearner
h2o.varimp(metalearner)
h2o.varimp_plot(metalearner)

gbm <- h2o.getModel(grep("GBM", model_ids, value = TRUE)[1])
h2o.varimp(gbm)
h2o.varimp_plot(gbm)

exa <- h2o.explain(aml, test)
exa

exm <- h2o.explain(aml@leader, test)
exm

save.image(file = "env/sociodem_bin.RData")

h2o.shutdown()


# eda all variables -------------------------------------------------------

d_miss %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

d_miss %>% drop_na() %>% binarize() %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")

gdata::keep(df, all = TRUE, sure = TRUE)