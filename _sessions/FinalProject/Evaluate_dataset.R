# Checking out dataset for final project in Bern R Bootcamp
# Michael

# packages
library(tidyverse)
#library("tidylog", warn.conflicts = FALSE)
library(geonames)
library(nasapower)
options(geonamesUsername="schultem")
options(geonamesHost="api.geonames.org")

weather <- read_csv('_sessions/FinalProject/1_Data/brazil_wheather.csv')


# PROCESS APPOINTMENTS ----------

# load dataset
appointments <- read_csv('_sessions/FinalProject/1_Data/medical_noshows.csv')

# dplyr magic
appointments = appointments %>%
  rename(NoShow = "No-show") %>%
  mutate_if(function(x) all(x %in% c(0, 1)), as.logical)
  
# write_csv('_sessions/FinalProject/1_Data/medical_noshows.csv') # run once!


# GET COORDINATES -----------

# get unique neighborhoods
uni_neighbourhood <- unique(appointments$Neighbourhood)

# function to request lon lat from geonames API
GNsearchAF <- function(x) {  
  res <- GNsearch(name=x, country="BR")  
  return(res[1, ])  
  }

# # loop over city names and reformat  
# GNresult <- sapply(uni_neighbourhood, GNsearchAF)  
# GNresult <- do.call(rbind, GNresult)  
# GNresult <- cbind(city=row.names(GNresult),  
#                   GNresult %>% select(lng, lat, adminName1)) %>%
#                   as.tibble()
# 
# write_csv(GNresult, '_sessions/FinalProject/1_Data/latlon_brazil.csv')


# GET WHEATHER -----------

GNresult = read_csv('_sessions/FinalProject/1_Data/latlon_brazil.csv')

test_coord <- GNresult[1:3,2:3]

                   # get_power(community = "AG",
                   #           lonlat = c(-47.8821658, -15.7942287),
                   #           pars = c("RH2M", "T2M", "PRECTOT"),
                   #           dates = c("2015-11-09", "2016-11-10"),
                   #           temporal_average = "DAILY")
 
test_coord$lnglat <- noquote(paste0(test_coord$lng, ' ', test_coord$lat))
c(test_coord$lnglat[1])

res <- matrix(nrow=nrow(GNresult), ncol=3)
for (i in 1:nrow(GNresult)){
  print(i)
  res[i, ] <-  get_power(community = "AG",
                       lonlat = c(-47.8821658, -15.7942287), # GNresult %>% slice(i) %>% select(lng, lat) %>% unlist() %>% round(2),
                       pars = c("RH2M", "T2M", "PRECTOT"),
                       dates = c("2016-11-09", "2016-11-10"),
                       temporal_average = "DAILY")
                }    

?get_power