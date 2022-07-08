
library(tidyverse)
load("df/2015.RData")
load("df/2016.RData")
load("df/2017.RData")
load("df/2018.RData")
load("df/2019.RData")
load("df/2020.RData")
load("df/2021.RData")

common_vars <- Reduce(intersect,
                      list(colnames(d15),
                           colnames(d16),
                           colnames(d17),
                           colnames(d18),
                           colnames(d19),
                           colnames(d20),
                           colnames(d21)))
# there are 392 intersecting variables across 7 DFs
# raceombmulti is problematic
# has weird character type in one of the frames

d15 <- d15 %>% select(common_vars, -raceombmulti)
d16 <- d16 %>% select(common_vars, -raceombmulti)
d17 <- d17 %>% select(common_vars, -raceombmulti)
d18 <- d18 %>% select(common_vars, -raceombmulti)
d19 <- d19 %>% select(common_vars, -raceombmulti)
d20 <- d20 %>% select(common_vars, -raceombmulti)
d21 <- d21 %>% select(common_vars, -raceombmulti)

library(vctrs)
df <- vec_rbind(d15, d16, d17, d18, d19, d20, d21)

save(df, file = "df/data.RData")
gdata::keep(df, all = TRUE, sure = TRUE)

naniar::miss_var_summary(df) %>% rio::export(file = "missingness_summary.xlsx")
