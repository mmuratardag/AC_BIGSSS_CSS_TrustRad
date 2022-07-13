
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

gdata::keep(df, all = TRUE, sure = TRUE)


# https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html
# https://docs.h2o.ai/h2o/latest-stable/h2o-docs/explain.html


# https://h2o-release.s3.amazonaws.com/h2o/rel-zumbo/3/docs-website/h2o-r/docs/articles/getting_started.html

# if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
# if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
# 
# pkgs <- c("RCurl","jsonlite")
# for (pkg in pkgs) {
#   if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
# }
# 
# install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")))


# see
# https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html


# auto-ML -----------------------------------------------------------------

library(h2o)
# initialize h2o engine
h2o.init(nthreads = -1, max_mem_size = "24G") # adjust memory size here
# define the data frame as h2o object
df <- as.h2o(df)
# see descriptive stats of the DF
h2o.describe(df)
# define the outcome/dependent/target variable
y <- "tp1"
# make the train/test split
splits <- h2o.splitFrame(df, ratios = 0.8, seed = 123)
train <- splits[[1]]
test <- splits[[2]]
# start the auto-ml model
aml <- h2o.automl(y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 900,
                  seed = 321,
                  project_name = "ExtSocDemPredGT")
# print the best model with predictive power
print(aml@leaderboard)
# get the model ids from the h2o output
model_ids <- as.data.frame(aml@leaderboard$model_id)[,1]
se <- h2o.getModel(grep("StackedEnsemble_AllModels", model_ids, value = TRUE)[1])
metalearner <- h2o.getModel(se@model$metalearner$name)

# model metrics from the best model
metalearner

# variable importance for stacked models
h2o.varimp(metalearner)
h2o.varimp_plot(metalearner)

# extract the best model
xgb <- h2o.getModel(grep("XGBoost", model_ids, value = TRUE)[1])
# variable importance from the best model
h2o.varimp(xgb)
# variable importance plot from the best model
h2o.varimp_plot(xgb)


# explain -----------------------------------------------------------------

# https://docs.h2o.ai/h2o/latest-stable/h2o-docs/explain.html

# Explain leader model & compare with all AutoML models
exa <- h2o.explain(aml, test)
exa

# Explain a single H2O model (e.g. leader model from AutoML)
exm <- h2o.explain(aml@leader, test)
exm

save.image(file = "env/baseline_model.RData")

h2o.shutdown()


# post-hoc eda ------------------------------------------------------------

load("df/data.RData")

ntile_na <- function(var, ntile_n) {
  notna <- !is.na(var)
  out <- rep(NA_real_,length(var))
  out[notna] <- ntile(var[notna],ntile_n)
  return(out)
}

df$age_bin <- ntile_na(df$age, 2)

df$age_bin <- factor(df$age_bin, levels = 1:2, labels = c("<median", ">median"))
table(df$age_bin)

df %>% ggplot(aes(x = tp1)) + geom_bar(aes(fill = age_bin)) + theme_bw()

df %>% select(-age) %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

df %>% select(-age) %>% drop_na() %>% binarize() %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")
