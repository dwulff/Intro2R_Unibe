

# get data
CIA_2018 = jsonlite::fromJSON('https://raw.githubusercontent.com/iancoleman/cia_world_factbook_api/master/data/factbook.json')
CIA_2008 = jsonlite::fromJSON('~/Downloads/weekly_json/2008-01-07_factbook.json')


# save data
saveRDS(CIA_2008, '~/Desktop/CIA2008_data.RDS')
saveRDS(CIA_2018, '~/Desktop/CIA2018_data.RDS')


names(CIA_2008)
names(CIA_2008[[1]])
names(CIA_2008[[2]])

names(CIA_2008[[1]][[1]][[1]])
names(CIA_2018[[1]][[1]][[1]])
names(CIA_2018[[1]][[1]][[1]]$military_and_security$expenditures)
names(CIA_2008[[1]][[1]][[1]]$energy)
names(CIA_2008[[1]][[1]][[1]]$government$legal_system)
names(CIA_2008[[1]][[1]][[1]][[4]])
names(CIA_2008[[1]][[1]][[1]][[economy]])
names(CIA_2008[[1]][[1]][[1]][[10]])


countries = names(CIA_2008[[1]])[-1]


cnt = countries[3]
cnt = 'china'


eval(parse(text = paste0("CIA_2008$countries[[cnt]]$data$", 'name')))
eval(parse(text = paste0("CIA_2008$countries[[cnt]]$data$", 'economy$gdp$per_capita_purchasing_power_parity$annual_values$value')))
`$`(CIA_2008$countries[[cnt]]$data, 'name')
`$`(CIA_2008$countries[[cnt]]$data, 'economy$gdp$per_capita_purchasing_power_parity$annual_values')

CIA_2008$countries[[cnt]]$data$name
CIA_2008$countries[[cnt]]$data$economy$gdp$per_capita_purchasing_power_parity$annual_values$value
CIA_2008$countries[[cnt]]$data$economy$imports$total_value$annual_values[1,1] # in USD
CIA_2008$countries[[cnt]]$data$economy$imports$partners$by_country[1,] # in USD
CIA_2008$countries[[cnt]]$data$economy$imports$partners$by_country[2,] # in USD
CIA_2008$countries[[cnt]]$data$economy$imports$partners$by_country[3,] # in USD
CIA_2008$countries[[cnt]]$data$economy$imports$commodities$by_commodity # in USD
CIA_2008$countries[[cnt]]$data$economy$exports$total_value$annual_values[1,1] # in USD
CIA_2008$countries[[cnt]]$data$economy$exports$partners$by_country[1,] # in USD
CIA_2008$countries[[cnt]]$data$economy$exports$partners$by_country[2,] # in USD
CIA_2008$countries[[cnt]]$data$economy$exports$partners$by_country[3,] # in USD
CIA_2008$countries[[cnt]]$data$economy$exports$commodities$by_commodity # in USD
CIA_2008$countries[[cnt]]$data$economy$inflation_rate$annual_values[1,1] # in USD
CIA_2008$countries[[cnt]]$data$economy$household_income_by_percentage_share$lowest_ten_percent$value # %
CIA_2008$countries[[cnt]]$data$economy$household_income_by_percentage_share$highest_ten_percent # %
CIA_2018$countries[[cnt]]$data$economy$unemployment_rate$annual_values[1,1] # %
CIA_2018$countries[[cnt]]$data$economy$industries$industries
CIA_2018$countries[[cnt]]$data$economy$central_bank_discount_rate
CIA_2018$countries[[cnt]]$data$economy$budget
CIA_2018$countries[[cnt]]$data$economy$gdp$real_growth_rate$annual_values[1,1]
CIA_2008$countries[[cnt]]$data$people$languages$language
CIA_2008$countries[[cnt]]$data$people$population$total
CIA_2008$countries[[cnt]]$data$people$urbanization$urban_population$value # per cent
CIA_2008$countries[[cnt]]$data$people$birth_rate$births_per_1000_population # per 1000
CIA_2008$countries[[cnt]]$data$people$life_expectancy_at_birth$male$value
CIA_2008$countries[[cnt]]$data$people$life_expectancy_at_birth$female$value
CIA_2008$countries[[cnt]]$data$people$infant_mortality_rate$male$value # per 1000
CIA_2008$countries[[cnt]]$data$people$infant_mortality_rate$female$value # per 1000
CIA_2008$countries[[cnt]]$data$people$literacy
CIA_2008$countries[[cnt]]$data$people$median_age$total$value
CIA_2008$countries[[cnt]]$data$people$net_migration_rate$migrants_per_1000_population
CIA_2008$countries[[cnt]]$data$people$religions$religion[,1:2]
CIA_2008$countries[[cnt]]$data$people$sex_ratio$total_population$value # male / female
CIA_2008$countries[[cnt]]$data$transnational_issues$disputes
CIA_2008$countries[[cnt]]$data$geography$area$total$value # sq km
CIA_2008$countries[[cnt]]$data$geography$area$land$value # sq km
CIA_2008$countries[[cnt]]$data$geography$climate
CIA_2008$countries[[cnt]]$data$geography$geographic_coordinates$latitude$degrees
CIA_2008$countries[[cnt]]$data$geography$geographic_coordinates$longitude$degrees
CIA_2008$countries[[cnt]]$data$geography$natural_resources$resources
CIA_2008$countries[[cnt]]$data$geography$environment$current_issues
CIA_2008$countries[[cnt]]$data$military_and_security$expenditures$annual_values[1,1] # % of gdp
CIA_2018$countries[[cnt]]$data$energy$electricity$by_source$other_renewable_sources$percent
CIA_2008$countries[[cnt]]$data$government$legal_system



# ---- Econ

# vars
vars = c(
"name",
"economy$gdp$per_capita_purchasing_power_parity$annual_values$value",
"economy$gdp$real_growth_rate$annual_values[1,1]",
"economy$inflation_rate$annual_values[1,1]", # in USD
"economy$central_bank_discount_rate",
"economy$budget$revenues$value",
"economy$budget$expenditures$value",
"economy$household_income_by_percentage_share$lowest_ten_percent$value", # %
"economy$household_income_by_percentage_share$highest_ten_percent$value", # %
"economy$unemployment_rate$annual_values[1,1]", # %
"economy$industries$industries",
"economy$exports$total_value$annual_values[1,1]", # in USD
"economy$exports$partners$by_country[1,]", # in USD
"economy$exports$partners$by_country[2,]", # in USD
"economy$exports$partners$by_country[3,]", # in USD
"economy$exports$commodities$by_commodity", # in USD
"economy$imports$total_value$annual_values[1,1]", # in USD
"economy$imports$partners$by_country[1,]", # in USD
"economy$imports$partners$by_country[2,]", # in USD
"economy$imports$partners$by_country[3,]", # in USD
"economy$imports$commodities$by_commodity" # in USD
)

# names
nams = c(
'gdp_per_capita|USD',
'growth_rate|%',
'centralbank_discount_rate|%',
'revenue|USD',
'',
'',
'',
'',
'',
'',
'',
'',

)

# 2008

fun = function(x){
  d = eval(parse(text = paste0("CIA_2008$countries[[cnt]]$data$", x)))
  if(x == "economy$industries$industries"){
    return(paste(d, collapse = ';'))
  }
  if(stringr::str_detect(x, 'partners[:print:]by_country')){
    return(paste0(paste(unlist(d),collapse = ':'),'%'))
    }
  if(stringr::str_detect(x, 'commodities[:print:]by_commodity')){
    return(paste(d,collapse = ';'))
    }
  d
  }
v = lapply(vars, fun)
v[[16]]

vars[16]
vars[14]











