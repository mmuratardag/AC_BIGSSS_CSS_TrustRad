
load("df/data_complete_obs.RData")

library(tidyverse)

d_miss %>% skimr::skim()

d_miss <- d_miss %>% mutate(
  age_cat = case_when(age <= 44 ~ "young",
                      age > 44 & age <= 65 ~ "midage",
                      age >= 65 ~ "old") 
)

d_miss$age_cat <- factor(d_miss$age_cat)

d_miss %>% skimr::skim()

colnames(d_miss)

log_reg_op_sd <- glm(tp1 ~ age_cat + gender + education + race + ethnicity + occupation +
                      religion + religiosity,
                     data = d_miss, family = binomial(link="logit"))
summary(log_reg_op_sd)
fmsb::NagelkerkeR2(log_reg_op_sd)

library(sjPlot)
plot_model(log_reg_op_sd, type = "eff", terms = "age_cat")
