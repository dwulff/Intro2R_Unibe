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


# Converting categorical variables to factors
appointments$Gender <- factor(appointments$Gender, levels = c("M", "F"))
appointments$NoShow <- factor((appointments$`No-show`))
appointments$Neighbourhood <- factor((appointments$Neighbourhood))

# Converting all logical flags 
appointments$Diabetes <- as.logical(appointments$Diabetes)
appointments$Alcoholism <- as.logical(appointments$Alcoholism)
appointments$Hypertension <- as.logical(appointments$Hipertension)
appointments$Handicapped <- as.logical(appointments$Handcap)
appointments$Scholarship <- as.logical(appointments$Scholarship)
appointments$SMS_received <- as.logical(appointments$SMS_received)


appointments$Handcap <- NULL
appointments$Hipertension <- NULL
appointments$`No-show` <- NULL

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

# https://www.kaggle.com/ravishkalra/medical-appointment-no-show-prediction