# Checking out dataset for final project in Bern R Bootcamp
# Michael

# packages
library(tidyverse)
library("tidylog", warn.conflicts = FALSE)
library(geonames)
options(geonamesUsername="schultem")
options(geonamesHost="api.geonames.org")

install.packages("rjson") 
install_github("ropensci/geonames")




# load dataset
appointments <- read_csv('_sessions/FinalProject/1_Data/medical_noshows.csv')
weather <- read_csv('_sessions/FinalProject/1_Data/brazil_wheather.csv')


# remove quotes
appointments$NoShow <- appointments$`No-show`
appointments <- select(appointments, -`No-show`)

# Converting all logical flags 
appointments$Diabetes <- as.logical(appointments$Diabetes)
appointments$Alcoholism <- as.logical(appointments$Alcoholism)
appointments$Hypertension <- as.logical(appointments$Hipertension)
appointments$Handicapped <- as.logical(appointments$Handcap)
appointments$Scholarship <- as.logical(appointments$Scholarship)
appointments$SMS_received <- as.logical(appointments$SMS_received)

# write_csv('_sessions/FinalProject/1_Data/medical_noshows.csv') # run once!


# we need coordinates for the locations in appointments ----
neighbourhood <- appointments$Neighbourhood 
unique_neighbourhood <- unique(appointments$Neighbourhood)

# function to request lon lat from geonames API
GNsearchAF <- function(x) {  
  res <- GNsearch(name=x, country="BR")  
  return(res[1, ])  
}

# loop over city names and reformat  
GNresult <- sapply(unique_neighbourhood, GNsearchAF)  
GNresult <- do.call("rbind", GNresult)  
GNresult <- cbind(city=row.names(GNresult),  
                  subset(GNresult, select=c("lng", "lat", "adminName1")))

write_csv(GNresult, '_sessions/FinalProject/1_Data/LatLonBrazil.csv')

#get weather data

library(nasapower)

test_coord <- GNresult[1:3,2:3]

                   get_power(community = "AG",
                             lonlat = c(-47.8821658, -15.7942287),
                             pars = c("RH2M", "T2M", "PRECTOT"),
                             dates = c("2015-11-09", "2016-11-10"),
                             temporal_average = "DAILY"
)
                   
                   
                   
?get_power

# https://www.kaggle.com/ravishkalra/medical-appointment-no-show-prediction