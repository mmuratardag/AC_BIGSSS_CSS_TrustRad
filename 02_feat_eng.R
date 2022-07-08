
## to be aupdated/Ccleaned

load("df/Data.RData")
library(tidyverse)
colnames(df)

d <- df %>% select(session_id,
                   session_status,
                   study_name,
                   date,
                   month,
                   day,
                   year,
                   hour,
                   weekday,
                   previous_session_schema,
                   previous_session_id,
                   STATE,
                   MSANo,
                   CountyNo,
                   MSAName,
                   tp1,
                   edu,
                   edu_14,
                   ethnicityomb,
                   birthyear,
                   religion2014,
                   politicalid_7,
                   D_biep.White_Good_all,
                   religionid,
                   cab2,
                   cab1,
                   cab3,
                   cab5,
                   cab4,
                   cab6)
n_distinct(d$session_id) # 196108

rm(df)

d %>% select(edu, edu_14) %>% correlation::correlation() # 1

d <- d %>% select (-edu_14, religiosity = religionid,
                   con_lib_self_plc = politicalid_7) %>% 
  mutate(age = year - birthyear,
         ethnicity = as_factor(ethnicityomb))

d$tp1 <- factor(d$tp1, levels = 1:2, labels = c("Most People Can Be Trusted",
                                                "Can't Be Too Careful"))
d$ethnicity <- factor(d$ethnicity,
                      levels = 1:3,
                      labels = c("Hispanic or Latino",
                                 "Not Hispanic or Latino",
                                 "Unknown"))
library(naniar)
d %>% select(cab2:cab6) %>% vis_miss(warn_large_data = FALSE)
d <- d %>% select(session_id,
                  tp1, age, edu, ethnicity, religiosity, con_lib_self_plc,
                  IAT_score = D_biep.White_Good_all,
                  cab2:cab6) %>% drop_na()

library(lavaan)
cfa_model <- "cab =~ cab1 + cab2 + cab3 + cab5 + cab4 + cab6"
model_fit <- cfa(model = cfa_model, data = d, estimator = "mlr", mimic = "mplus",
                 std.ov = TRUE, std.lv = TRUE)
summary(model_fit, fit.measures = TRUE, standardized = TRUE, rsquare = TRUE)

cfa_model_2d <- "
cab_ind =~ cab1 + cab2 + cab3
cab_soc =~ cab5 + cab4 + cab6
"
model_fit_2d <- cfa(model = cfa_model_2d, data = d, estimator = "mlr", mimic = "mplus",
                    std.ov = TRUE, std.lv = TRUE)
summary(model_fit_2d, fit.measures = TRUE, standardized = TRUE, rsquare = TRUE)
library(semTools)
round(reliability(model_fit_2d),2)

d <- d %>% mutate(cab_ind = lavPredict(model_fit_2d, type = "lv", method = "EBM",
                                       label = TRUE, fsm = TRUE)[, "cab_ind"],
                  cab_soc = lavPredict(model_fit_2d, type = "lv", method = "EBM",
                                       label = TRUE, fsm = TRUE)[, "cab_soc"])


d$cab_ind <- scales::rescale(d$cab_ind, to = c(0,1), from = range(d$cab_ind,
                                                                  na.rm = FALSE,
                                                                  finite = TRUE))
d$cab_soc <- scales::rescale(d$cab_soc, to = c(0,1), from = range(d$cab_soc,
                                                                  na.rm = FALSE,
                                                                  finite = TRUE))

d <- d %>% select(session_id:IAT_score,
                  cab_ind, cab_soc)

save(d, file = "df/data_feat_eng.RData")

gdata::keep(d, all = TRUE, sure = TRUE)

