require(gapminder)
require(readxl)
require(tidyverse)

gap = gapminder::gapminder

mort = read_excel('~/Downloads/indicator gapminder under5mortality.xlsx')
mort = gather(mort, year, childMort, -`Under five mortality`)
mort$year = as.numeric(stringr::str_sub(mort$year, 1, 4))
names(mort)[1] = 'country'

co2 = read_excel('~/Downloads/indicator CDIAC carbon_dioxide_total_emissions.xlsx')
co2 = gather(co2, year, co2Emit, -`CO2 emission total`)
co2$year = as.numeric(stringr::str_sub(co2$year, 1, 4))
names(co2)[1] = 'country'

health = read_excel('~/Downloads/indicator_per capita total expenditure on health (ppp int. $).xlsx')
health = gather(health, year, healthExp, -`Per capita total expenditure on health (PPP int. $)`)
health$year = as.numeric(stringr::str_sub(health$year, 1, 4))
names(health)[1] = 'country'
health$healthExp = as.numeric(health$healthExp)

gap = gap %>% 
  inner_join(mort, by = c('country', 'year')) %>%
  inner_join(co2, by = c('country', 'year')) %>%
  inner_join(health, by = c('country', 'year')) 


write_csv(gap, '_sessions/StatisticsII/1_Data/gap.csv')



sum(is.na(gap$healthExp))
