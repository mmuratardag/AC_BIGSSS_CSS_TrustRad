# Test: Carina changes something. This can get deleted later.

# the logic of the pipeline is the following:

# read/load
# zap
# select
# convert & save

# please cross-check the non-available variables in each year's DF
# with the code-book
# a second pair of eyes/brain should sense check/control this

source("variable_name_list.R")
library(haven)
library(tidyverse)

d15 <- read_sav("raw_data/Race IAT.public.2015.sav") %>% zap_missing() %>%
  zap_label() %>% zap_labels() %>% zap_formats() %>% zap_widths() %>%
  drop_na(tp1) %>%
  mutate(across(where(is.character), ~na_if(., ".")))

d15_union <- intersect(colnames(d15), sv)
# the following variables are not available in year 2015
setdiff(sv, colnames(d15))
# [1] "num_002"                   "raceomb_002"               "birthsex"                  "genderidentity"           
# [5] "countrycit_num"            "countryres_num"            "occupation_self_002"       "occupation_selfdetail_001"
# [9] "att7" 

d15 <- d15 %>% select(all_of(d15_union))

dim(d15) # 24692   465
save(d15, file = "df/2015.RData")
rm(d15, d15_union); gc()

prep_wo_pipe <- function(data_frame_path) {
  
  # get the data frame
  df <- read_sav(data_frame_path) %>% zap_missing() %>% 
    zap_label() %>% zap_labels() %>% zap_formats() %>% zap_widths() %>% 
    drop_na(tp1) %>%
    mutate(across(where(is.character), ~na_if(., ".")))
  
  # see the variables available in the data frame
  var_union <- intersect(colnames(df), sv)
  
  # see what variable is not available in the data frame
  var_diff <- setdiff(sv, colnames(df))
  
  # select the available variables in the data frame
  df <- df %>% select(all_of(var_union))
  
  return(list(df = df, non_avail_vars = var_diff))
  
}

d16_ls_op <- prep_wo_pipe("raw_data/Race IAT.public.2016.sav")
d16 <- d16_ls_op %>% .$df
d16_ls_op %>% .$non_avail_vars
# "countrycit_num" "countryres_num"
dim(d16) # 23966   472
save(d16, file = "df/2016.RData")
gdata::keep(sv, prep_wo_pipe, all = TRUE, sure = TRUE); gc()

d17_ls_op <- prep_wo_pipe("raw_data/Race_IAT.public.2017.sav")
d17 <- d17_ls_op %>% .$df
d17_ls_op %>% .$non_avail_vars
# [1] "num"                  "raceomb"              "sex_5"                "countrycit"          
# [5] "countryres"           "employment"           "occuself"             "occupation_self"     
# [9] "occuselfdetail"       "occusupporter"        "occupation_supporter" "occusupporterdetail" 
# [13] "financialsupport"     "incomeself"           "incomesupporter"      "wealthself"          
# [17] "wealthsupporter"      "tblack_1to11"         "twhite_1to11"         "bxp03"               
# [21] "bxp04"                "bxpa01"               "bxpa02"               "bxpa03"              
# [25] "bxpa04"               "bxpa05"               "bxpa06"               "bxpa07"              
# [29] "bxpa08"               "bxpb01"               "bxpb02"               "bxpb03"              
# [33] "bxpb04"               "bxpb05"               "bxpb06"               "pt1"                 
# [37] "pt2"                  "pt3"                  "pt4"                  "pt5"                 
# [41] "pt6"                  "ra1"                  "ra2"                  "ra3"                 
# [45] "ra4"                  "ra5"                  "ra6"                  "ra7"                 
# [49] "ra8"                  "ra9"                  "ra10"                 "ra11"                
# [53] "ra12"                 "ra13"                 "ra14"                 "raceargumentscale1"  
# [57] "raceargumentscale2"   "raceargumentscale3"   "raceargumentscale4"   "raceargumentscale5"  
# [61] "raceargumentscale6"   "raceargumentscale7"   "raceargumentscale8"   "raceargumentscale9"  
# [65] "raceargumentscale10"  "raceargumentscale11"  "raceargumentscale12"  "raceargumentscale13" 
dim(d17) # 23852   406
save(d17, file = "df/2017.RData")
gdata::keep(sv, prep_wo_pipe, all = TRUE, sure = TRUE); gc()


d18_ls_op <- prep_wo_pipe("raw_data/Race_IAT.public.2018.sav")
d18 <- d18_ls_op %>% .$df
d18_ls_op %>% .$non_avail_vars
# [1] "user_id"              "num"                  "raceomb"              "sex_5"               
# [5] "countrycit"           "countryres"           "employment"           "occupation_self"     
# [9] "occusupporter"        "occupation_supporter" "occusupporterdetail"  "financialsupport"    
# [13] "incomeself"           "incomesupporter"      "wealthself"           "wealthsupporter"     
# [17] "tblack_0to10"         "tblack_1to11"         "twhite_0to10"         "twhite_1to11"        
# [21] "att7"                 "bxp03"                "bxp04"                "bxpa01"              
# [25] "bxpa02"               "bxpa03"               "bxpa04"               "bxpa05"              
# [29] "bxpa06"               "bxpa07"               "bxpa08"               "bxpb01"              
# [33] "bxpb02"               "bxpb03"               "bxpb04"               "bxpb05"              
# [37] "bxpb06"               "pt1"                  "pt2"                  "pt3"                 
# [41] "pt4"                  "pt5"                  "pt6"                  "ra1"                 
# [45] "ra2"                  "ra3"                  "ra4"                  "ra5"                 
# [49] "ra6"                  "ra7"                  "ra8"                  "ra9"                 
# [53] "ra10"                 "ra11"                 "ra12"                 "ra13"                
# [57] "ra14"                 "raceargumentscale1"   "raceargumentscale2"   "raceargumentscale3"  
# [61] "raceargumentscale4"   "raceargumentscale5"   "raceargumentscale6"   "raceargumentscale7"  
# [65] "raceargumentscale8"   "raceargumentscale9"   "raceargumentscale10"  "raceargumentscale11" 
# [69] "raceargumentscale12"  "raceargumentscale13" 
dim(d18) # 21642   404
save(d18, file = "df/2018.RData")
gdata::keep(sv, prep_wo_pipe, all = TRUE, sure = TRUE); gc()


d19_ls_op <- prep_wo_pipe("raw_data/Race_IAT.public.2019.sav")
d19 <- d19_ls_op %>% .$df
d19_ls_op %>% .$non_avail_vars
# [1] "user_id"              "num"                  "raceomb"              "sex_5"               
# [5] "birthsex"             "genderidentity"       "countrycit"           "countryres"          
# [9] "employment"           "occuself"             "occupation_self"      "occuselfdetail"      
# [13] "occusupporter"        "occupation_supporter" "occusupporterdetail"  "financialsupport"    
# [17] "incomeself"           "incomesupporter"      "wealthself"           "wealthsupporter"     
# [21] "tblack_0to10"         "tblack_1to11"         "twhite_0to10"         "twhite_1to11"        
# [25] "att_7"                "bxp03"                "bxp04"                "bxpa01"              
# [29] "bxpa02"               "bxpa03"               "bxpa04"               "bxpa05"              
# [33] "bxpa06"               "bxpa07"               "bxpa08"               "bxpb01"              
# [37] "bxpb02"               "bxpb03"               "bxpb04"               "bxpb05"              
# [41] "bxpb06"               "pt1"                  "pt2"                  "pt3"                 
# [45] "pt4"                  "pt5"                  "pt6"                  "ra1"                 
# [49] "ra2"                  "ra3"                  "ra4"                  "ra5"                 
# [53] "ra6"                  "ra7"                  "ra8"                  "ra9"                 
# [57] "ra10"                 "ra11"                 "ra12"                 "ra13"                
# [61] "ra14"                 "raceargumentscale1"   "raceargumentscale2"   "raceargumentscale3"  
# [65] "raceargumentscale4"   "raceargumentscale5"   "raceargumentscale6"   "raceargumentscale7"  
# [69] "raceargumentscale8"   "raceargumentscale9"   "raceargumentscale10"  "raceargumentscale11" 
# [73] "raceargumentscale12"  "raceargumentscale13" 
dim(d19) # 22369   400
save(d19, file = "df/2019.RData")
gdata::keep(sv, prep_wo_pipe, all = TRUE, sure = TRUE); gc()

d20_ls_op <- prep_wo_pipe("raw_data/Race.IAT.public.2020.sav")
d20 <- d20_ls_op %>% .$df
d20_ls_op %>% .$non_avail_vars
# [1] "user_id"                   "num"                       "raceomb"                  
# [4] "raceomb_002"               "sex_5"                     "birthsex"                 
# [7] "genderidentity"            "countrycit"                "countryres"               
# [10] "employment"                "occuself"                  "occupation_self"          
# [13] "occuselfdetail"            "occupation_selfdetail_001" "occusupporter"            
# [16] "occupation_supporter"      "occusupporterdetail"       "financialsupport"         
# [19] "incomeself"                "incomesupporter"           "wealthself"               
# [22] "wealthsupporter"           "tblack_0to10"              "tblack_1to11"             
# [25] "twhite_0to10"              "twhite_1to11"              "att_7"                    
# [28] "bxp03"                     "bxp04"                     "bxpa01"                   
# [31] "bxpa02"                    "bxpa03"                    "bxpa04"                   
# [34] "bxpa05"                    "bxpa06"                    "bxpa07"                   
# [37] "bxpa08"                    "bxpb01"                    "bxpb02"                   
# [40] "bxpb03"                    "bxpb04"                    "bxpb05"                   
# [43] "bxpb06"                    "pt1"                       "pt2"                      
# [46] "pt3"                       "pt4"                       "pt5"                      
# [49] "pt6"                       "ra1"                       "ra2"                      
# [52] "ra3"                       "ra4"                       "ra5"                      
# [55] "ra6"                       "ra7"                       "ra8"                      
# [58] "ra9"                       "ra10"                      "ra11"                     
# [61] "ra12"                      "ra13"                      "ra14"                     
# [64] "raceargumentscale1"        "raceargumentscale2"        "raceargumentscale3"       
# [67] "raceargumentscale4"        "raceargumentscale5"        "raceargumentscale6"       
# [70] "raceargumentscale7"        "raceargumentscale8"        "raceargumentscale9"       
# [73] "raceargumentscale10"       "raceargumentscale11"       "raceargumentscale12"      
# [76] "raceargumentscale13" 
dim(d20) # 44379   398
save(d20, file = "df/2020.RData")
gdata::keep(sv, prep_wo_pipe, all = TRUE, sure = TRUE); gc()

d21_ls_op <- prep_wo_pipe("raw_data/Race IAT.public.2021.sav")
d21 <- d21_ls_op %>% .$df
d21_ls_op %>% .$non_avail_vars
# [1] "user_id"                   "num"                       "raceomb"                  
# [4] "raceomb_002"               "sex_5"                     "birthsex"                 
# [7] "genderidentity"            "countrycit"                "countryres"               
# [10] "employment"                "occuself"                  "occupation_self"          
# [13] "occuselfdetail"            "occupation_selfdetail_001" "occusupporter"            
# [16] "occupation_supporter"      "occusupporterdetail"       "financialsupport"         
# [19] "incomeself"                "incomesupporter"           "wealthself"               
# [22] "wealthsupporter"           "tblack_0to10"              "tblack_1to11"             
# [25] "twhite_0to10"              "twhite_1to11"              "att_7"                    
# [28] "bxp03"                     "bxp04"                     "bxpa01"                   
# [31] "bxpa02"                    "bxpa03"                    "bxpa04"                   
# [34] "bxpa05"                    "bxpa06"                    "bxpa07"                   
# [37] "bxpa08"                    "bxpb01"                    "bxpb02"                   
# [40] "bxpb03"                    "bxpb04"                    "bxpb05"                   
# [43] "bxpb06"                    "pt1"                       "pt2"                      
# [46] "pt3"                       "pt4"                       "pt5"                      
# [49] "pt6"                       "ra1"                       "ra2"                      
# [52] "ra3"                       "ra4"                       "ra5"                      
# [55] "ra6"                       "ra7"                       "ra8"                      
# [58] "ra9"                       "ra10"                      "ra11"                     
# [61] "ra12"                      "ra13"                      "ra14"                     
# [64] "raceargumentscale1"        "raceargumentscale2"        "raceargumentscale3"       
# [67] "raceargumentscale4"        "raceargumentscale5"        "raceargumentscale6"       
# [70] "raceargumentscale7"        "raceargumentscale8"        "raceargumentscale9"       
# [73] "raceargumentscale10"       "raceargumentscale11"       "raceargumentscale12"      
# [76] "raceargumentscale13" 
dim(d21) # 35208   398
save(d21, file = "df/2021.RData")
