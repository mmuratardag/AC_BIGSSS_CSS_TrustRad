
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
# load("01_raw_data_RData_files/2015.RData")

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
         occupation = occupation,
         race = raceomb,
         ethnicity = ethnicityomb,
         education = edu,
         religion = religion2014,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack, twhite,
         all_of(scale_items))

dim(d15) # 24692   446

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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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


# religion 2015 -----------------------------------------------------------

table(d15$religion)
d15$religion <- factor(d15$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d15$religion)


# occupation 2015 ---------------------------------------------------------

table(d15$occupation)

d15 <- d15 %>% naniar::replace_with_na(replace = list(occupation = -999))
d15$occupation <- as_factor(d15$occupation) %>% 
  fct_collapse(Employed = c("99-0001", "00-0000", "11-0000", "11-2000",
                            "11-3000", "11-9000", "13-1000", "13-2000",
                            "15-1000", "15-2000", "17-1000", "17-2000",
                            "17-3000", "19-1000", "19-2000",
                            "19-3000", "19-4000", "21-1000", "21-2000",
                            "23-1000", "23-2000", "25-1000", "25-2000",
                            "25-3000", "25-4000", "25-9000", "25-9999",
                            "27-1000", "27-2000", "27-3000", "27-4000",
                            "29-1000", "29-2000", "31-1000", "31-2000", 
                            "31-9000", "33-1000", "33-3000", "33-9000",
                            "35-1000", "35-2000", "35-3000", "35-9000",
                            "37-1000", "37-3000", "39-3000", "39-5000",
                            "39-6000",
                            "39-9000", "41-1000", "41-2000", "41-3000",
                            "41-4000",
                            "41-9000", "43-1000", "43-3000", "43-4000",
                            "43-5000", "43-6000", "43-9000", "45-2000",
                            "45-4000",
                            "45-9000", "47-1000", "47-2000", "47-5000",
                            "49-2000",
                            "49-3000", "49-9000", "51-1000", "51-2000",
                            "51-4000", "51-5000", "51-8000", "51-9000",
                            "53-1000",
                            "53-2000", "53-3000", "53-4000", "53-6000",
                            "55-1000",
                            "55-2000", "55-3000"),
               Unemployed = c("99-9999"))
table(d15$occupation)


# desc stats 2015 ---------------------------------------------------------

d15 %>% select(tp1,
               age, gender, 
               occupation,
               education, race, ethnicity,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()


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

# load("01_raw_data_RData_files/2016.RData")

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
         occupation = occupation_self_002,
         race = raceomb,
         ethnicity = ethnicityomb,
         education = edu,
         religion = religion2014,
         religiosity = religionid,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack, twhite,
         all_of(scale_items))

dim(d16) # 23966   446

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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2016 -----------------------------------------------------------

table(d16$religion)
d16$religion <- factor(d16$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d16$religion)



# employment 2016 ---------------------------------------------------------

d16 <- d16 %>% naniar::replace_with_na(replace = list(occupation = -999))
d16$occupation <- as_factor(d16$occupation) %>% 
  fct_collapse(Employed = c("23-", "21-", "11-", "13-", "25-", "15-", "35-",
                            "41-", "2931", "17-", "55-", "43-", "47-", "27-",
                            "19-", "39-", "53-", "33-", "49-" ,"00-", "51-",
                            "45-", "37-"),
               Unemployed = c("9998"))
table(d16$occupation)

# desc stats 2016 ---------------------------------------------------------

d16 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()

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

# load("01_raw_data_RData_files/2017.RData")

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
         occupation = occupation_self_002,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         religion = religion2014,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack = tblack_0to10, twhite = twhite_0to10,
         all_of(scale_items_2017))

dim(d17) # 23852   397


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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2017 -----------------------------------------------------------

table(d17$religion)
d17$religion <- factor(d17$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d17$religion)

# employment 2017 ---------------------------------------------------------

table(d17$occupation)

d17 <- d17 %>% naniar::replace_with_na(replace = list(occupation = -99))
d17$occupation <- as_factor(d17$occupation) %>% 
  fct_collapse(Employed = c("00-",  "11-",  "13-",  "15-",  "17-",  "19-",
                            "21-",  "23-",  "25-",  "27-",  "293",  "33-",
                            "35-",  "37-",  "39-",  "41-",  "43-",  "45-",
                            "47-",  "49-",  "51-",  "53-", "55-"),
               Unemployed = c("999"))
table(d17$occupation)


# desc stats 2017 ---------------------------------------------------------

d17 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save remove 2017 --------------------------------------------------------

save(d17, file = "df/2017.RData")
rm(d17); gc()


# 2018 --------------------------------------------------------------------

d18 <- prep_wo_pipe("00_raw_data_sav_files/Race_IAT.public.2018.sav")

colnames(d18)

save(d18, file = "01_raw_data_RData_files/2018.RData")

# load("01_raw_data_RData_files/2018.RData")

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
         occupation = occupation_self_002,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         religion = religion2014,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att_7,
         tblack = tblacks_0to10, twhite = twhites_0to10,
         all_of(scale_items_2018))

dim(d18) # 21642   396


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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2018 -----------------------------------------------------------

table(d18$religion)
d18$religion <- factor(d18$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d18$religion)

# employment 2018 ---------------------------------------------------------

table(d18$occupation)

d18 <- d18 %>% naniar::replace_with_na(replace = list(occupation = c(-99, -999)))
d18$occupation <- as_factor(d18$occupation) %>% 
  fct_collapse(Employed = c("00-",  "11-",  "13-",  "15-",  "17-",  "19-",
                            "21-",  "23-",  "25-",  "27-",  "293",  "2931",
                            "33-",
                            "35-",  "37-",  "39-",  "41-",  "43-",  "45-",
                            "47-",  "49-",  "51-",  "53-", "55-"),
               Unemployed = c("9998", "999"))
table(d18$occupation)


# descriptive stats 2018 --------------------------------------------------

d18 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save & remove 2018 ------------------------------------------------------

save(d18, file = "df/2018.RData")
rm(d18); gc()


# 2019 --------------------------------------------------------------------

d19 <-  prep_wo_pipe("00_raw_data_sav_files/Race_IAT.public.2019.sav")

# load("01_raw_data_RData_files/2019.RData")

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
         occupation = occupation_self_002,
         race = raceomb_002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         religion = religion2014,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d19) # 22369   396


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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2019 -----------------------------------------------------------

table(d19$religion)
d19$religion <- factor(d19$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d19$religion)


# employment 2019 ---------------------------------------------------------

table(d19$occupation)

d19$occupation <- as_factor(d19$occupation) %>% 
  fct_collapse(Employed = c("00-",  "11-",  "13-",  "15-",  "17-",  "19-",
                            "21-",  "23-",  "25-",  "27-",  "2931",
                            "33-",
                            "35-",  "37-",  "39-",  "41-",  "43-",  "45-",
                            "47-",  "49-",  "51-",  "53-", "55-"),
               Unemployed = c("9998"))
table(d19$occupation)


# desc stats 2019 ---------------------------------------------------------

d19 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save & remove 2019 ------------------------------------------------------

save(d19, file = "df/2019.RData")
rm(d19); gc()


# 2020 --------------------------------------------------------------------

d20 <- prep_wo_pipe("00_raw_data_sav_files/Race.IAT.public.2020.sav")

# load("01_raw_data_RData_files/2020.RData")

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
         occupation = occupation_self_002,
         race = raceomb002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         religion = religion2014,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d20) # 44379   396


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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2020 -----------------------------------------------------------

table(d20$religion)
d20$religion <- factor(d20$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d20$religion)


# employment 2020 ---------------------------------------------------------

table(d20$occupation)

d20$occupation <- as_factor(d20$occupation) %>% 
  fct_collapse(Employed = c("00-",  "11-",  "13-",  "15-",  "17-",  "19-",
                            "21-",  "23-",  "25-",  "27-",  "2931",
                            "33-",
                            "35-",  "37-",  "39-",  "41-",  "43-",  "45-",
                            "47-",  "49-",  "51-",  "53-", "55-"),
               Unemployed = c("9998"))
table(d20$occupation)


# desc stats 2020 ---------------------------------------------------------

d20 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()

# save & remove 2020 ------------------------------------------------------

save(d20, file = "df/2020.RData")
rm(d20); gc()


# 2021 --------------------------------------------------------------------

d21 <- prep_wo_pipe("00_raw_data_sav_files/Race IAT.public.2021.sav")

colnames(d21)

# load("01_raw_data_RData_files/2021.RData")

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
         occupation = occupation_self_002,
         race = raceomb002,
         ethnicity = ethnicityomb,
         education = edu,
         religiosity = religionid,
         religion = religion2014,
         con_lib_self_plc = politicalid_7,
         IAT_D_score = D_biep.White_Good_all,
         pref_whites = att7,
         tblack = Tblack_0to10, twhite = Twhite_0to10,
         all_of(scale_items_2018))

dim(d21) # 35208   396

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
                              UniBelow = c("Elementary_School",
                                           "JrHighMiddle_School",
                                           "SomeHigh_School",
                                           "HighSchool_Grad"),
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

# religion 2021 -----------------------------------------------------------

table(d21$religion)
d21$religion <- factor(d21$religion,
                       levels = 1:8,
                       labels = c("Buddist_Confucian_Shinto",
                                  "Catholic_Orthodox",
                                  "Protestant_Other",
                                  "Hindu",
                                  "Jewish",
                                  "Muslim",
                                  "Not_Religious",
                                  "Other_Religion"))
table(d21$religion)

# employment 2021 ---------------------------------------------------------

table(d21$occupation)

d21 <- d21 %>% naniar::replace_with_na(replace = list(occupation = c(-999)))

d21$occupation <- as_factor(d21$occupation) %>% 
  fct_collapse(Employed = c("00-",  "11-",  "13-",  "15-",  "17-",  "19-",
                            "21-",  "23-",  "25-",  "27-",  "2931",
                            "33-",
                            "35-",  "37-",  "39-",  "41-",  "43-",  "45-",
                            "47-",  "49-",  "51-",  "53-", "55-"),
               Unemployed = c("9998"))
table(d21$occupation)


# desc stats 2021 ---------------------------------------------------------

d21 %>% select(tp1,
               age, gender,
               occupation,
               education, race, ethnicity, occupation,
               religion, religiosity,
               con_lib_self_plc,
               tblack, twhite, pref_whites) %>% skimr::skim()


# save 2021 ---------------------------------------------------------------

save(d21, file = "df/2021.RData")

gdata::keep(d21, all = TRUE, sure = TRUE)

gc()

# merge DFs ---------------------------------------------------------------
load("df/2015.RData") 
d15 <- d15 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
load("df/2016.RData") 
d16 <- d16 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
load("df/2017.RData") 
d17 <- d17 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
load("df/2018.RData") 
d18 <- d18 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
load("df/2019.RData") 
d19 <- d19 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
load("df/2020.RData") 
d20 <- d20 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)
d21 <- d21 %>% select(tp1,
                      age, gender,
                      education, race, ethnicity, occupation,
                      religion, religiosity)

library(vctrs)
df <- vec_rbind(d15, d16, d17, d18, d19, d20, d21)

save(df, file = "df/data.RData")
gdata::keep(df, all = TRUE, sure = TRUE)

naniar::vis_miss(df, warn_large_data = FALSE) + theme_bw()
# naniar::miss_var_summary(df) %>% rio::export(file = "missingness_summary.xlsx")

