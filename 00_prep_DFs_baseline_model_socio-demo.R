
# source("variable_name_list.R")

source("scale_items_list.R")
library(haven)
library(tidyverse)
sssn <- c(
  # sssn
  "user_id",
  "study_name",
  "session_status",
  "previous_session_id",
  "previous_session_schema",
  "month",
  "day",
  "year",
  "hour",
  "weekday",
  "date",
  "session_id")



# 2015 --------------------------------------------------------------------

d15 <- read_sav("00_raw_data_sav_files/Race IAT.public.2015.sav") %>% zap_missing() %>%
  zap_label() %>% zap_labels() %>% zap_formats() %>% zap_widths() %>%
  drop_na(tp1) %>%
  mutate(across(where(is.character), ~na_if(., "."))) %>%
  mutate(across(where(is.character), ~ na_if(.,"")))

save(d15, file = "01_raw_data_RData_files/2015.RData")

colnames(d15)

# select variables for 2015 -----------------------------------------------

d15 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d15 %>% select(att, att_7) %>% correlation::correlation()

d15 <- d15 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = sex_5,
         age,
         race = raceomb,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack, twhite,
         att,
         all_of(scale_items))

dim(d15) # 24692   445

colnames(d15)

# GT 2015 -----------------------------------------------------------------


d15$tp1 <- factor(d15$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2015 -------------------------------------------------------------

table(d15$gender)
d15$gender <- factor(d15$gender, levels = 1:5,
                     labels = c("Male",
                                "Female",
                                "TransMTF",
                                "TransFTM",
                                "Other"))

d15$gender <- fct_collapse(d15$gender,
                           Male = "Male", Female = "Female",
                           Other = c("TransMTF",
                                     "TransFTM",
                                     "Other"))
table(d15$gender)


# edu 2015 ----------------------------------------------------------------

table(d15$education)
d15$education <- factor(d15$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d15$education <- fct_collapse(d15$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d15$education)
# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#          2           15          248          144         1449
# better collapse even further to uni vs. lower degree


# race 2015 ---------------------------------------------------------------

table(d15$race)
d15$race <- factor(d15$race, levels = 1:9,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "BlackWhiteMixed",
                              "MixedRaceOther",
                              "OtherUnknown"))

d15$race <- fct_collapse(d15$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = c("BlackWhiteMixed",
                                            "MixedRaceOther"),
                         OtherUnknown = "OtherUnknown")

table(d15$race)

# ethnicity 2015 ----------------------------------------------------------

table(d15$ethnicity)
d15$ethnicity <- factor(d15$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d15$ethnicity)


# desc stats 2015 ---------------------------------------------------------

d15 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, att) %>% skimr::skim()


# save & remove 2015 ------------------------------------------------------

save(d15, file = "df/2015.RData")
rm(d15); gc()

# DRY function ------------------------------------------------------------

prep_wo_pipe <- function(data_frame_path) {
  
  df <- read_sav(data_frame_path) %>% zap_missing() %>% 
    zap_label() %>% zap_labels() %>% zap_formats() %>% zap_widths() %>% 
    drop_na(tp1) %>%
    mutate(across(where(is.character), ~na_if(., "."))) %>%
    mutate(across(where(is.character), ~ na_if(.,"")))
  return(df)

}

# 2016 --------------------------------------------------------------------

d16 <- prep_wo_pipe("00_raw_data_sav_files/Race IAT.public.2016.sav")

colnames(d16)

save(d16, file = "01_raw_data_RData_files/2016.RData")

d16 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d16 %>% select(att, att_7) %>% correlation::correlation()


# select variables 2016 ---------------------------------------------------

d16 <- d16 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = sex_5,
         age,
         race = raceomb,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack, twhite,
         att,
         all_of(scale_items))

dim(d16) # 23966   445

colnames(d16)


# GT 2016 -----------------------------------------------------------------

d16$tp1 <- factor(d16$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))

# gender 2016 -------------------------------------------------------------

table(d16$gender)
d16$gender <- factor(d16$gender, levels = 1:5,
                     labels = c("Male",
                                "Female",
                                "TransMTF",
                                "TransFTM",
                                "Other"))

d16$gender <- fct_collapse(d16$gender,
                           Male = "Male", Female = "Female",
                           Other = c("TransMTF",
                                     "TransFTM",
                                     "Other"))
table(d16$gender)


# edu 2016 ----------------------------------------------------------------

table(d16$education)
d16$education <- factor(d16$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d16$education <- fct_collapse(d16$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d16$education)
# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#         19          104          450          371         2291 
# better collapse here as well


# race 2016 ---------------------------------------------------------------

table(d16$race)
d16$race <- factor(d16$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d16$race <- fct_collapse(d16$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d16$race)



# ethnicity 2016 ----------------------------------------------------------

table(d16$ethnicity)
d16$ethnicity <- factor(d16$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d16$ethnicity)


# desc stats 2016 ---------------------------------------------------------

d16 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, att) %>% skimr::skim()

d16 %>% arrange(desc(age)) %>% select(age)
d16 %>% arrange(age) %>% select(age)
d16 <- d16 %>% naniar::replace_with_na_at(.vars = c("age"),
                                          condition = ~.x %in% c(2006,
                                                                 2005,
                                                                 2003,
                                                                 2002,
                                                                 1997,
                                                                 1985,
                                                                 17, 16, 15,
                                                                 14, 13, 12,
                                                                 11, 10, 9,
                                                                 8, 7))

# save remove 2016 --------------------------------------------------------

save(d16, file = "df/2016.RData")
rm(d16); gc()



# 2017 --------------------------------------------------------------------

d17 <- prep_wo_pipe("00_raw_data_sav_files/Race_IAT.public.2017.sav")

colnames(d17)

save(d17, file = "01_raw_data_RData_files/2017.RData")

d17 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d17 %>% select(att, att_7) %>% correlation::correlation()
d17 %>% select(att_7)


# select variables 2017 ---------------------------------------------------

d17 <- d17 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = birthsex,
         age,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack = tblack_0to10, twhite = twhite_0to10,
         att = att_7,
         all_of(scale_items_2017))

dim(d17) # 23852   396


# GT 2017 -----------------------------------------------------------------

d17$tp1 <- factor(d17$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2017 -------------------------------------------------------------

table(d17$gender)
d17$gender <- factor(d17$gender, levels = 1:2,
                     labels = c("Male",
                                "Female"))
table(d17$gender)


# edu 2017 ----------------------------------------------------------------

table(d17$education)
d17$education <- factor(d17$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d17$education <- fct_collapse(d17$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d17$education)
# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#        135          606         2618         2555        15630 


# race 2017 ---------------------------------------------------------------

table(d17$race)
d17$race <- factor(d17$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d17$race <- fct_collapse(d17$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d17$race)


# ethnicity 2017 ----------------------------------------------------------

table(d17$ethnicity)
d17$ethnicity <- factor(d17$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d17$ethnicity)


# desc stats 2017 ---------------------------------------------------------

d17 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, att) %>% skimr::skim()


# save remove 2017 --------------------------------------------------------

save(d17, file = "df/2017.RData")
rm(d17); gc()


# 2018 --------------------------------------------------------------------

d18 <- prep_wo_pipe("00_raw_data_sav_files/Race_IAT.public.2018.sav")

colnames(d18)

save(d18, file = "01_raw_data_RData_files/2018.RData")

d18 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d18 %>% select(att, att_7) %>% correlation::correlation()
d18 %>% select(att_7)


# select variables 2018 ---------------------------------------------------

sssn_2018 <- c(
  # sssn
  # "user_id",
  "study_name",
  "session_status",
  "previous_session_id",
  "previous_session_schema",
  "month",
  "day",
  "year",
  "hour",
  "weekday",
  "date",
  "session_id")

d18 <- d18 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn_2018),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = birthsex,
         age,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack = tblacks_0to10, twhite = twhites_0to10,
         att = att_7,
         all_of(scale_items_2018))

dim(d18) # 23852   396


# GT 2018 -----------------------------------------------------------------

d18$tp1 <- factor(d18$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2018 -------------------------------------------------------------

table(d18$gender)
d18$gender <- factor(d18$gender, levels = 1:2,
                     labels = c("Male",
                                "Female"))
table(d18$gender)


# edu 2018 ----------------------------------------------------------------

table(d18$education)
d18$education <- factor(d18$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d18$education <- fct_collapse(d18$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d18$education)

# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#        144          584         2570         2217        14042 


# race 2018 ---------------------------------------------------------------

table(d18$race)
d18$race <- factor(d18$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d18$race <- fct_collapse(d18$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d18$race)


# ethnicity 2018 ----------------------------------------------------------

table(d18$ethnicity)
d18$ethnicity <- factor(d18$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d18$ethnicity)


# descriptive stats 2018 --------------------------------------------------

d18 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, att) %>% skimr::skim()


# save & remove 2018 ------------------------------------------------------

save(d18, file = "df/2018.RData")
rm(d18); gc()


# 2019 --------------------------------------------------------------------

d19 <-  prep_wo_pipe("00_raw_data_sav_files/Race_IAT.public.2019.sav")

colnames(d19)

save(d19, file = "01_raw_data_RData_files/2019.RData")

d19 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d19 %>% select(att, att_7) %>% correlation::correlation()
d19 %>% select(att_7)
d19 %>% select(att7)


# select variables 2019 ---------------------------------------------------


d19 <- d19 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn_2018),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = birthSex,
         age,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d19) # 22369   394


# GT 2019 -----------------------------------------------------------------

d19$tp1 <- factor(d19$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2019 -------------------------------------------------------------

table(d19$gender)
d19$gender <- factor(d19$gender, levels = 1:2,
                     labels = c("Male",
                                "Female"))
table(d19$gender)


# edu 2019 ----------------------------------------------------------------

table(d19$education)
d19$education <- factor(d19$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d19$education <- fct_collapse(d19$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d19$education)

# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#        128          618         2769         2334        14310


# race 2019 ---------------------------------------------------------------

table(d19$race)
d19$race <- factor(d19$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d19$race <- fct_collapse(d19$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d19$race)


# ethnicity 2019 ----------------------------------------------------------

table(d19$ethnicity)
d19$ethnicity <- factor(d19$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d19$ethnicity)


# desc stats 2019 ---------------------------------------------------------

d19 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save & remove 2019 ------------------------------------------------------

save(d19, file = "df/2019.RData")
rm(d19); gc()


# 2020 --------------------------------------------------------------------

d20 <- prep_wo_pipe("00_raw_data_sav_files/Race.IAT.public.2020.sav")

colnames(d20)

save(d20, file = "01_raw_data_RData_files/2020.RData")

d20 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d20 %>% select(contains("att"))


# select variables 2020 ---------------------------------------------------

d20 <- d20 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn_2018),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = birthSex,
         age,
         race = raceomb002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d20) # 44379   394


# GT 2020 -----------------------------------------------------------------

d20$tp1 <- factor(d20$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2020 -------------------------------------------------------------

table(d20$gender)

d20 <- d20 %>% naniar::replace_with_na(replace = list(gender = -999))

d20$gender <- factor(d20$gender, levels = 1:2,
                     labels = c("Male",
                                "Female"))
table(d20$gender)


# edu 2020 ----------------------------------------------------------------

table(d20$education)
d20$education <- factor(d20$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d20$education <- fct_collapse(d20$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d20$education)


# race 2020 ---------------------------------------------------------------

table(d20$race)
d20$race <- factor(d20$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d20$race <- fct_collapse(d20$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d20$race)


# ethnicity 2020 ----------------------------------------------------------


table(d20$ethnicity)
d20$ethnicity <- factor(d20$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d20$ethnicity)


# desc stats 2020 ---------------------------------------------------------

d20 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, pref_whites) %>% skimr::skim()

# save & remove 2020 ------------------------------------------------------

save(d20, file = "df/2020.RData")
rm(d20); gc()


# 2021 --------------------------------------------------------------------

d21 <- prep_wo_pipe("00_raw_data_sav_files/Race IAT.public.2021.sav")

colnames(d21)

save(d21, file = "01_raw_data_RData_files/2021.RData")

d21 %>% select(contains(c("tblack", "twhite"))) %>% correlation::correlation()
d21 %>% select(contains("att"))

# select variables 2021 ---------------------------------------------------

d21 <- d21 %>% mutate(age = year - birthyear) %>%
  select(all_of(sssn_2018),
         MSANo, CountyNo, MSAName,
         tp1,
         gender = birthSex,
         age,
         race = raceomb002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d21) # 35208   394

# GT 2021 -----------------------------------------------------------------

d21$tp1 <- factor(d21$tp1, levels = 1:2,
                  labels = c("Most People Can Be Trusted",
                             "Can't Be Too Careful"))


# gender 2021 -------------------------------------------------------------

table(d21$gender)

d21$gender <- factor(d21$gender, levels = 1:2,
                     labels = c("Male",
                                "Female"))
table(d21$gender)

# edu 2021 ----------------------------------------------------------------

table(d21$education)
d21$education <- factor(d21$education, levels = 1:14,
                        labels = c("Elementary_School",
                                   "JrHighMiddle_School",
                                   "SomeHigh_School",
                                   "HighSchool_Grad",
                                   "SomeCollege",
                                   "Associate_Degree",
                                   "BA",
                                   "SomeGrad_School",
                                   "MA",
                                   "MBA",
                                   "JD",
                                   "MD",
                                   "PhD",
                                   "OtherAdvancedDegree"))

d21$education <- fct_collapse(d21$education,
                              Elementary = c("Elementary_School"),
                              JrHighMiddle = c("JrHighMiddle_School"),
                              SomeHigh = c("SomeHigh_School"),
                              HighSchool = c("HighSchool_Grad"),
                              UniAbove = c("SomeCollege",
                                           "Associate_Degree",
                                           "BA",
                                           "SomeGrad_School",
                                           "MA",
                                           "MBA",
                                           "JD",
                                           "MD",
                                           "PhD",
                                           "OtherAdvancedDegree"))

table(d21$education)

# Elementary JrHighMiddle     SomeHigh   HighSchool     UniAbove 
#        158          699         2748         3312        24786 

# race 2021 ---------------------------------------------------------------

table(d21$race)
d21$race <- factor(d21$race, levels = 1:8,
                   labels = c("AmericanIndianAlaskaNative",
                              "EastAsian",
                              "SouthAsian",
                              "NativeHawaianPacific",
                              "AfricanAmerican",
                              "White",
                              "OtherUnknown",
                              "MixedRaceOther"))

d21$race <- fct_collapse(d21$race,
                         NativeAmerican = c("AmericanIndianAlaskaNative",
                                            "NativeHawaianPacific"),
                         Asian = c("EastAsian","SouthAsian"),
                         AfricanAmerican = "AfricanAmerican",
                         White = "White",
                         MixedRaceOther = "MixedRaceOther",
                         OtherUnknown = "OtherUnknown")

table(d21$race)

# ethnicity 2021 ----------------------------------------------------------


table(d21$ethnicity)
d21$ethnicity <- factor(d21$ethnicity,
                        levels = 1:3,
                        labels = c("Hispanic or Latino",
                                   "Not Hispanic or Latino",
                                   "Unknown"))
table(d21$ethnicity)

# desc stats 2020 ---------------------------------------------------------

d21 %>% select(tp1, age, gender, education, race, ethnicity,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save 2021 ---------------------------------------------------------------

save(d21, file = "df/2021.RData")

gdata::keep(d21, all = TRUE, sure = TRUE)

gc()

# merge DFs ---------------------------------------------------------------
load("df/2015.RData") 
d15 <- d15 %>% select(tp1, age, gender, education, race, ethnicity)
load("df/2016.RData") 
d16 <- d16 %>% select(tp1, age, gender, education, race, ethnicity)
load("df/2017.RData") 
d17 <- d17 %>% select(tp1, age, gender, education, race, ethnicity)
load("df/2018.RData") 
d18 <- d18 %>% select(tp1, age, gender, education, race, ethnicity)
load("df/2019.RData") 
d19 <- d19 %>% select(tp1, age, gender, education, race, ethnicity)
load("df/2020.RData") 
d20 <- d20 %>% select(tp1, age, gender, education, race, ethnicity)
d21 <- d21 %>% select(tp1, age, gender, education, race, ethnicity)

library(vctrs)
df <- vec_rbind(d15, d16, d17, d18, d19, d20, d21)

save(df, file = "df/data.RData")
gdata::keep(df, all = TRUE, sure = TRUE)

naniar::vis_miss(df, warn_large_data = FALSE) + theme_bw()
# naniar::miss_var_summary(df) %>% rio::export(file = "missingness_summary.xlsx")

