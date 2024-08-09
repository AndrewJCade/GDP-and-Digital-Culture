clear all
capture log close
set more off
cd "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data"
log using "res.smcl", replace

*****Importing Excels into Statasets*****
import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\CAPITAL_API_NE.GDI.TOTL.CD_DS2_en_excel_v2_868.xls", sheet("THIS ONE") firstrow
rename CountryName Country
rename CountryCode ISO
reshape long y, i(ISO) j(year)
rename y Capital
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\capital.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\digbehavior.xlsx", sheet("MUSIC") firstrow
reshape long y, i(Country) j(year)
rename y mus
sort Country year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\music.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\digbehavior.xlsx", sheet("YOUTUBE") firstrow
reshape long y, i(Country) j(year)
rename y ytb
sort Country year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\youtube.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\digbehavior.xlsx", sheet("TV") firstrow
reshape long y, i(Country) j(year)
rename y tv
sort Country year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\tv.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\GDP_Data_Extract_From_World_Development_Indicators.xlsx", sheet("THIS ONE") firstrow
rename CountryCode ISO
rename CountryName Country
reshape long y, i(ISO) j(year)
rename y GDP
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\gdp.dta", replace
clear

import delimited "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\HDR21-22_Composite_indices_complete_time_series.csv", case(preserve) 
reshape long y, i(ISO) j(year)
rename y HDI
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\hdi.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\misc data\ictfromgdp_copy.xlsx", sheet("Data") firstrow
destring Year, generate(year)
duplicates drop Country year, force
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\ictfromgdp.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\LABOR_API_SL.EMP.TOTL.SP.ZS_DS2_en_excel_v2_2543.xls", sheet("THIS ONE") firstrow
rename ISOCode ISO
reshape long y, i(ISO) j(year)
rename y labor
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\labor.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\MCI_Data_2022.xlsx", sheet("THIS ONE") firstrow
rename ISOCode ISO
rename Year year
rename Index MCI
sort ISO year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\mci.dta", replace
clear

import excel "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\excels\rGDPpct_copy.xlsx", sheet("Sheet1") firstrow
reshape long y, i(Country) j(year)
rename y rgdp
sort Country year
save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\rgdp_copy.dta", replace
clear

*****merging statasets*****

use "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\rgdp_copy.dta"

replace Country="Bahamas" if Country=="Bahamas, The"
replace Country="China" if Country=="China, People's Republic of"
replace Country="Cong, Dem. Rep. of the" if Country=="Congo, Democratic Republic"
replace Country="Congo, Republic of" if Country=="Congo"
replace Country="Czechia" if Country=="Czech Republic"
replace Country="Cote d'lvoire" if Country=="Côte d'Ivoire"
replace Country="Dominican Republic" if Country=="Dominica"
replace Country="Guinea" if Country=="Equatorial Guinea"
replace Country="Gambia" if Country=="Gambia, The"
replace Country="Hong Kong" if Country=="Hong Kong SAR"
replace Country="Korea, South" if Country=="Korea, Republic of"
replace Country="Kyrgyzstan" if Country=="Kyrgyz Republic"
replace Country="LAO" if Country=="Lao P.D.R."
replace Country="Slovakia" if Country=="Slovak Republic"
replace Country="South Sudan" if Country=="South Sudan, Republic of"
replace Country="Turkey" if Country=="Türkiye, Republic of"
replace Country="United States of America" if Country=="United States"

sort Country year
duplicates drop Country year, force
merge 1:1 Country year using MCI.dta
drop if _merge==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

replace Country="Bahamas, The" if Country=="Bahamas"
replace Country="Congo Dem. Rep." if Country=="Congo, Dem. Rep. of the"
replace Country="Congo, Rep." if Country=="Congo, Republic of"
replace Country="Egypt, Arab Rep." if Country=="Egypt"
replace Country="Gambia, The" if Country=="Gambia"
replace Country="Hong Kong SAR, China" if Country=="Hong Kong"
replace Country="Iran, Islamic Rep." if Country=="Iran"
replace Country="Korea, Rep." if Country=="Korea, South"
replace Country="Kyrgyz Replublic" if Country=="Kyrgysztan"
replace Country="Lao PDR" if Country=="LAO"
replace Country="Macao SAR, China" if Country=="Macao SAR"
replace Country="Micronesia, Fed. Sts." if Country=="Micronesia, Fed. States of"
replace Country="St. Kitts and Nevis" if Country=="Saint Kitts and Nevis"
replace Country="St. Lucia" if Country=="Saint Lucia"
replace Country="St. Vincent and the Grenadines" if Country=="Saint Vincent and the Grenadines"
replace Country="Slovak Republic" if Country=="Slovakia"
replace Country="Syrian Arab Republic" if Country=="Syria"
replace Country="Sao Tome and Principe" if Country=="São Tomé and Príncipe"
replace Country="United States" if Country=="United States of America"
replace Country="Venezuela, RB" if Country=="Venezuela"
replace Country="Viet Nam" if Country=="Vietnam"
replace Country="Yemen, Rep." if Country=="Yemen"

sort Country year
merge 1:1 Country year using capital.dta
drop if _merge==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

replace Country="Turkiye" if Country=="Turkey"

sort Country year
merge 1:1 Country year using gdp.dta
drop if _merge ==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

replace Country="Bahamas" if Country=="Bahamas, The"
replace Country="Bolivia (Plurinational State of)" if Country=="Bolivia"
replace Country="Congo (Democratic Republic of the)" if Country=="Congo Dem. Rep."
replace Country="Congo" if Country=="Congo, Republic of"
replace Country="Egypt" if Country=="Egypt, Arab Rep."
replace Country="Eswatini (Kingdom of)" if Country=="Eswatini"
replace Country="Gambia" if Country=="Gambia, The"
replace Country="Hong Kong, China (SAR)" if Country=="Hong Kong SAR, China"
replace Country="Iran (Islamic Republic of)" if Country=="Iran, Islamic Rep."
replace Country="Korea (Republic of)" if Country=="Korea, Rep."
replace Country="LAO" if Country=="Lao PDR"
replace Country="Micronesia (Federated States of)" if Country=="Micronesia, Fed. Sts."
replace Country="Moldova (Republic of)" if Country=="Moldova"
replace Country="Slovakia" if Country=="Slovak Republic"
replace Country="Saint Kitts and Nevis" if Country=="St. Kitts and Nevis"
replace Country="Saint Lucia" if Country=="St. Lucia"
replace Country="Saint Vincent and the Grenadines" if Country=="St. Vincent and the Grenadines"
replace Country="Tanzania (United Republic of)" if Country=="Tanzania"
replace Country="Turkey" if Country=="Turkiye"
replace Country="Venezuela (Bolivarian Republic of)" if Country=="Venezuela, RB"
replace Country="Yemen" if Country=="Yemen, Rep."

sort Country year
merge 1:1 Country year using hdi.dta
drop if _merge==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

replace Country="Bahamas, The" if Country=="Bahamas"
replace Country="Bolivia" if Country=="Bolivia (Plurinational State of)"
replace Country="Congo, Dem. Rep." if Country=="Congo (Democratic Republic of the)"
replace Country="Congo, Rep." if Country=="Congo, Republic of"
replace Country="Egypt, Arab Rep." if Country=="Egypt"
replace Country="Eswatini" if Country=="Eswatini (Kingdom of)"
replace Country="Gambia, The" if Country=="Gambia"
replace Country="Hong Kong SAR, China" if Country=="Hong Kong, China (SAR)"
replace Country="Iran, Islamic Rep." if Country=="Iran (Islamic Republic of)"
replace Country="Korea, Rep." if Country=="Korea (Republic of)"
replace Country="Kyrgyz Republic" if Country=="Kyrgyzstan"
replace Country="Lao PDR" if Country=="LAO"
replace Country="Micronesia, Fed. Sts." if Country=="Micronesia (Federated States of)"
replace Country="Moldova" if Country=="Moldova (Republic of)"
replace Country="St. Kitts and Nevis" if Country=="Saint Kitts and Nevis"
replace Country="St. Lucia" if Country=="Saint Lucia"
replace Country="St. Vincent and the Grenadines" if Country=="Saint Vincent and Grenadines"
replace Country="Slovak Republic" if Country=="Slovakia"
replace Country="Tanzania" if Country=="Tanzania (United Republic of)"
replace Country="Turkiye" if Country=="Turkey"
replace Country="Venezuela, RB" if Country=="Venezuela (Bolivarian Republic of)"
replace Country="Yemen, Rep." if Country=="Yemen"

sort Country year
merge 1:1 Country year using labor.dta
drop if _merge==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

replace Country="Korea" if Country=="Korea, Rep."
replace Country="Türkiye" if Country=="Turkiye"
replace Country="Egypt" if Country=="Egypt, Arab Rep."

merge 1:1 Country year using youtube.dta
drop if _merge==2
drop _merge

merge 1:1 Country year using tv.dta
drop if _merge==2
drop _merge

merge 1:1 Country year using music.dta
drop if _merge==2
drop _merge

merge 1:1 Country year using ictfromgdp.dta
drop if _merge==2
drop _merge

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace

*****Tapering the Variables to needs*****
drop Region Cluster Infrastructure Affordability
drop ConsumerReadiness ContentandServices Networkcoverage Networkperformance Otherenablinginfrastructure Spectrum Mobiletariffs Handsetprices Taxation Inequality MobileOwnership BasicSkills GenderEquality LocalRelevance Availability OnlineSecurity GCoverage Z AA AB Mobiledownloadspeeds Mobileuploadspeeds Mobilelatencies Accesstoelectricity Serversperpopulation InternationalInternetbandwidth IXPsperpopulation DigitaldividendspectrumMHzp Otherspectrumbelow1GHzMHzp Spectrumin13GHzbandsMHzpe Spectrumabove3GHzbandsMHzp SpectruminmmWavebandsMHzpe Entrybasket100MB Mediumbasket500MB Highbasket1GB Premiumbasket5GB Deviceprice TaxasaofTCMO MobilespecifictaxesasofTC AV Mobileownership Literacy SchoolLifeExpectancy MeanYearsofSchooling TertiaryEnrolment Genderparityinschooling Genderparityinaccountownersh Genderparityinincome WBLScore Gendergapinsocialmediause Gendergapinmobileownership TLDspercapita EGovernmentScore MobileSocialMediaPenetration Appsdevelopedperperson Numberofappsinnationallangu Accessibilityoftoprankedapps CybersecurityIndex IndicatorName IndicatorCode hdicode region
drop Indicator Breakdown Unitofmeasure
rename Value ictfromgdp

gen pctICT = ictfromgdp * 0.01
gen ICT = pctICT * Capital

gen pctL = labor * 0.01
gen AL = pctL * ICT
gen ln_AL = ln(AL)

gen KnICT = Capital - ICT
gen ln_KnICT = ln(KnICT)

gen ln_MCI = ln(MCI)

gen ln_HDI = ln(HDI)

gen pctYTB = ytb * 0.01
gen pctTV = tv * 0.01
gen pctMUS = mus * 0.01

save "C:\Users\Andre\OneDrive\Desktop\School\spring23\ECO490\Research Data\research.dta", replace


log close