
load("df/data.RData")

library(tidyverse)

colnames(df)

df <- df %>% naniar::replace_with_na(replace = list(age = c(6:16,
                                                            75:115)))

# mid-age > 45

table(df$race)
df$race <- fct_collapse(df$race,
                        EuropeanAmerican = "White",
                        nonEuropeanAmerican = c("NativeAmerican",
                                                "Asian",
                                                "AfricanAmerican",
                                                "MixedRaceOther",
                                                "OtherUnknown"))
table(df$race)

table(df$ethnicity)
df$ethnicity <- fct_collapse(df$ethnicity,
                        HispanicLatino = "Hispanic or Latino",
                        noHispanicLatino = c("Not Hispanic or Latino",
                                             "Unknown"))
table(df$ethnicity)

table(df$religion)
df$religion <- fct_collapse(df$religion,
                             Christian = c("Catholic_Orthodox",
                                            "Protestant_Other"),
                             nonChristian = c("Buddist_Confucian_Shinto",
                                              "Hindu", "Jewish", "Muslim",
                                              "Not_Religious",
                                              "Other_Religion"))
table(df$religion)

df$religiosity <- factor(df$religiosity, levels = 1:4,
                         labels = c("not at all religious",
                                    "slighlty religious",
                                    "moderately religious",
                                    "strongly religious"))
table(df$religiosity)
df$religiosity <- fct_collapse(df$religiosity,
                               NotReligious = c("not at all religious"),
                               Religious = c("slighlty religious",
                                             "moderately religious",
                                             "strongly religious"))
table(df$religiosity)

df %>% skimr::skim()

df %>% mutate(across(where(is.factor), as.numeric)) %>%
  correlation::correlation()

library(ppsr)
library(correlationfunnel)

df %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

df %>% drop_na() %>% binarize() %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")

gdata::keep(df, all = TRUE, sure = TRUE)

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
                  project_name = "DichSocDemPredGT")
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

save.image(file = "env/baseline_model_bin.RData")

h2o.shutdown()


