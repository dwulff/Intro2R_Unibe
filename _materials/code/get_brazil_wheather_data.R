
require(tidyverse)

d = read_csv('~/Downloads/KaggleV2-May-2016.csv')

head(d)

d

table(d$Neighbourhood)

min(d$ScheduledDay)
max(d$ScheduledDay)


library(nasapower)
daily_single_ag <- get_power(community = "AG",
                             lonlat = c(-47.8821658, -15.7942287),
                             pars = c("RH2M", "T2M", "PRECTOT"),
                             dates = c("2015-11-09", "2016-06-09"),
                             temporal_average = "DAILY"
)

class(daily_single_ag) <- c("tbl_df", "tbl", "data.frame")

write_csv(daily_single_ag, '1_Data/brazil_wheather.csv')


# 1. Daten einlesen
# 2. join
# 3. preprocess: time zone, day of the week
# 4. questions
#   no shows as a function of months or days of the week
#   can pattern be explained by wheather
#   individual differences: hypertension, diabetes, alcohol, handcap, sms_
#   interaction of individual differences and wheather





PRECTOT Precipitation
RH2M Relative Humidity at 2 Meters
T2M Temperature at 2 Meters