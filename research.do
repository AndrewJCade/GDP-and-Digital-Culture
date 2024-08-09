clear all
capture log close
set more off
cd "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data"
log using "research.smcl", replace
use research.dta

sum rgdp pctYTB pctTV pctMUS ln_HDI ln_MCI ln_AL ln_KnICT, detail

generate flag = 0
replace flag=1 if rgdp < -40 | rgdp > 80

sum rgdp if flag==0, detail

sum rgdp pctYTB pctTV pctMUS ln_HDI ln_MCI ln_AL ln_KnICT if flag==0, detail



regress rgdp ln_AL ln_KnICT if year>=2000 & year<=2021 & flag==0

*Cobb-Douglas Regression
regress rgdp ln_AL ln_KnICT if year>=2000 & year<=2021 & flag==0, vce(cluster Country)
sum rgdp if e(sample)==1, detail



regress rgdp ln_AL ln_KnICT ln_MCI ln_HDI if year>=2014 & year<=2021 & flag==0

**CD Regression w/ MCI and HDI
regress rgdp ln_AL ln_KnICT ln_MCI ln_HDI if year>=2014 & year<=2021 & flag==0, vce(cluster Country)
sum rgdp if e(sample)==1, detail



regress rgdp ln_AL ln_KnICT pctYTB pctTV pctMUS if year>=2014 & year<=2021 & flag==0

***CD with Dig Behaviors w/o HDI and MCI
regress rgdp ln_AL ln_KnICT pctYTB pctTV pctMUS if year>=2014 & year<=2021 & flag==0, vce(cluster Country)
sum rgdp if e(sample)==1, detail



regress rgdp ln_AL ln_KnICT ln_MCI ln_HDI pctYTB pctTV pctMUS if year>=2016 & year<=2021 & flag==0

****Prev. Regression with HDI and MCI
regress rgdp ln_AL ln_KnICT ln_MCI ln_HDI pctYTB pctTV pctMUS if year>=2016 & year<=2021 & flag==0, vce(cluster Country)
tab Country year if e(sample)==1
sum rgdp if e(sample)==1, detail
bro if e(sample)==1

encode Country, gen(CountryID)

xtset CountryID year
xtreg rgdp ln_AL ln_KnICT ln_MCI ln_HDI pctYTB pctTV pctMUS i.year if year>=2016 & year<=2021 & flag==0, fe i(CountryID)

estimates store fe
xtreg rgdp ln_AL ln_KnICT ln_MCI ln_HDI pctYTB pctTV pctMUS i.year if year>=2016 & year<=2021 & flag==0, re i(CountryID)
estimates store re
hausman fe re 

***no statistical significance for fe, regression ran w/o, only accounting for cluster. Homo assumed

log close