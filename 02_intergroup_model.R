
load("df/2015.RData")
load("df/2016.RData")
load("df/2017.RData")
load("df/2018.RData")
load("df/2019.RData")
load("df/2020.RData")
load("df/2021.RData")
library(tidyverse)

prep_dfs <- function(df) {
  df <- df %>% select(cab1:cab6,
                      tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity,
                      con_lib_self_plc,
                      tblack, twhite, pref_whites,
                      IAT_D_score) %>%
    mutate(cab = cab1 + cab2 + cab3 + cab4 + cab5 + cab6) %>%
    select(-c(cab1, cab2, cab3, cab4, cab5, cab6))
  return(df)
}

d15 <- prep_dfs(d15)
d16 <- prep_dfs(d16)
d17 <- prep_dfs(d17)
d18 <- prep_dfs(d18)
d19 <- prep_dfs(d19)
d20 <- prep_dfs(d20)
d21 <- prep_dfs(d21)

library(vctrs)
df <- vec_rbind(d15, d16, d17, d18, d19, d20, d21)

gdata::keep(df, all = TRUE, sure = TRUE)

df <- df %>% naniar::replace_with_na(replace = list(age = c(6:16,
                                                            75:115)))

df$race <- fct_collapse(df$race,
                        EuropeanAmerican = "White",
                        nonEuropeanAmerican = c("NativeAmerican",
                                                "Asian",
                                                "AfricanAmerican",
                                                "MixedRaceOther",
                                                "OtherUnknown"))

df$ethnicity <- fct_collapse(df$ethnicity,
                             HispanicLatino = "Hispanic or Latino",
                             noHispanicLatino = c("Not Hispanic or Latino",
                                                  "Unknown"))

df$religion <- fct_collapse(df$religion,
                            Christian = c("Catholic_Orthodox",
                                          "Protestant_Other"),
                            nonChristian = c("Buddist_Confucian_Shinto",
                                             "Hindu", "Jewish", "Muslim",
                                             "Not_Religious",
                                             "Other_Religion"))

df$religiosity <- factor(df$religiosity, levels = 1:4,
                         labels = c("not at all religious",
                                    "slighlty religious",
                                    "moderately religious",
                                    "strongly religious"))

df$religiosity <- fct_collapse(df$religiosity,
                               NotReligious = c("not at all religious"),
                               Religious = c("slighlty religious",
                                             "moderately religious",
                                             "strongly religious"))
df %>% naniar::vis_miss(warn_large_data = FALSE)
d_miss <- df %>% drop_na()
save(d_miss, file = "df/data_complete_obs.RData")
d_miss %>%  naniar::vis_miss(warn_large_data = FALSE)

library(ppsr)
library(correlationfunnel)

df %>% visualize_pps(do_parallel = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

df %>% drop_na() %>% binarize() %>%
  correlate(target = tp1__Most_People_Can_Be_Trusted) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")

df %>% mutate(across(where(is.factor), as.numeric)) %>%
  correlation::correlation()

library(h2o)
h2o.init(nthreads = -1, max_mem_size = "24G")
df <- as.h2o(df)
h2o.describe(df)
y <- "tp1"
splits <- h2o.splitFrame(df, ratios = 0.8, seed = 123)
train <- splits[[1]]
test <- splits[[2]]
aml <- h2o.automl(y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 900,
                  seed = 321,
                  project_name = "DichSocDemInterGroupPredGT")

print(aml@leaderboard)
model_ids <- as.data.frame(aml@leaderboard$model_id)[,1]
se <- h2o.getModel(grep("StackedEnsemble_AllModels", model_ids, value = TRUE)[1])
metalearner <- h2o.getModel(se@model$metalearner$name)

metalearner

h2o.varimp(metalearner)
h2o.varimp_plot(metalearner)

dl <- h2o.getModel(grep("DeepLearning", model_ids, value = TRUE)[1])
h2o.varimp(dl)
h2o.varimp_plot(dl)

exa <- h2o.explain(aml, test)
exa

exm <- h2o.explain(aml@leader, test)
exm

save.image(file = "env/intergroup_model.RData")

h2o.shutdown()
