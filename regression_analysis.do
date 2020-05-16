
clear
set more off

// covid 19 prison release policies and county population rate of infection

cd "/Users/`c(username)'/Box/Rachel's Personal Folder/covid19/MIT_COVID-19_Datathon"

// import prison data by county

import delimited "prison_county_df.csv", encoding(ISO-8859-1)

	*** (1) Clean prison data by county for merge with county demographics

drop v1

// pull out county name and state name

generate split = strpos(countystate,", ")

generate county = "" 
replace county = substr(countystate,1,split - 1)

generate state = "" 
replace state = substr(countystate, split + 1, .)

drop split

// create a date variable

gen stata_date = date(date, "YMD")

// deal with missing values

replace frac_released = "0" if frac_released == "NA"
destring frac_released, replace // 77066 missing values

// clean population data

destring census2010pop, force replace // 6217 missing values

sort county state

save "prison_county_df.dta", replace

	*** (2) Clean county demographic data for merge

clear

// import demographic data

import delimited "county_demographics_df.csv", encoding(ISO-8859-1)

drop v1

destring land_area, force replace // 302 missing
destring population_density, force replace // 302 missing

gen county_lower = strlower(county)
replace county = county_lower
drop county_lower

sort county state

save "county_demographics_df.dta", replace

	*** (3) Merge prison data by county and county demographic data

clear
use "prison_county_df.dta"

merge m:m county using "county_demographics_df"
tab _merge

rename _merge county_merge

save "prison_county_demographics_df.dta", replace

	*** (4) General linear models

clear
use "prison_county_demographics_df.dta"

tabmiss

gen log_diff_cases = log(diff_cases)
gen log_frac_released = log(frac_released)

reg log_diff_cases log_frac_released, robust // n = 13,720; r-sq = 0.0050; B1 = -.07821 (p<0.001)
reg log_diff_cases log_frac_released female_perc black_pop_perc asian_pop_perc hisp_pop_perc population_density, ro
	// n = 13,319; r-sq =  0.2080; B1 =  -.1205477 (p<0.001)
	
reg log_diff_cases log_frac_released female_perc black_pop_perc asian_pop_perc hisp_pop_perc population_density highrisk_agegroup_perc land_area age_55to64_perc age_65to74_perc age_75to84_perc, ro
	// n = 13,319; r-sq =  0.2080; B1 =  -.1205477 (p<0.001)


	**** (5). Output for reporting

clear
import delimited "/Users/rachelrosenberg/Box/Rachel's Personal Folder/covid19/MIT_COVID-19_Datathon/prison_county_df.csv"
	
destring frac_released, force replace
destring population_density, force replace
destring tot_pop, force replace
destring prison_capacity, force replace
destring prison_pop, force replace
destring highrisk_agegroup_perc, force replace
	
//  OLS regression

 glm diff_cases prison_county population_density tot_pop, ro
outreg2 using "Correlation_counties.xls", dec(3) replace excel

 glm diff_cases frac_released population_density tot_pop if prison_county==1, ro
outreg2 using "Output.xls", dec(3) replace excel

 glm diff_cases frac_released population_density tot_pop prison_pop if prison_county==1, ro
outreg2 using "Output.xls", dec(3) append excel

 glm diff_cases frac_released population_density tot_pop prison_pop highrisk_agegroup_perc if prison_county==1, ro
outreg2 using "Output.xls", dec(3) append excel



quietly reg log_diff_cases log_frac_released, ro
outreg2 using "Output_log.xls", dec(3) replace excel

quietly reg log_diff_cases log_frac_released, ro
outreg2 using "Output_log.xls", dec(3) replace excel

quietly reg log_diff_cases log_frac_released female_perc black_pop_perc asian_pop_perc hisp_pop_perc population_density, ro
outreg2 using "Output_log.xls", dec(3) append excel

quietly reg log_diff_cases log_frac_released female_perc black_pop_perc asian_pop_perc hisp_pop_perc population_density highrisk_agegroup_perc land_area age_55to64_perc age_65to74_perc age_75to84_perc, ro
outreg2 using "Output_log.xls", dec(3) append excel



















