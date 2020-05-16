# MIT_COVID-19_Datathon
This is the repository for 2020 MIT COVID-19 Datathon
## Research Question:

What is the impact of prison population reduction policies on COVID-19 infection rates in the surrounding county population?

## Hypotheses:
A. County-level COVID-19 rates are related to local prison populations

B. Counties with greater reductions in prison population will have lower COVID-19 infection rates

## Background:
We expand on existing research by looking at the relationship between reducing populations in prisons and the incidence of COVID-19 cases in surrounding counties. 

## Data:

1.Jail and Prison Data :Incarcerated COVID-19 rates

The Marshall Project data relies on testing availability, limited to some states

Jail and prison population and release data

UCLA Law Covid-19 Behind Bars Data Project - release rates over the entire state and among limited states*

Vera Institute of Justice (jail only)

2. State and County Data

Rates of COVID-19 infection

New York Times Covid-19 Data (county level): Census tract data, County demographics, population density. Indicator of a prison within county boundaries, Homeland Infrastructure Foundation Level Data

## Model:

GLM Model:

Covariate controls in a generalized linear model (GLM)

ΔC ~ r + p + d

ΔC: Weekly change in COVID-19 cases in prison county

r: Fraction of prisoners released statewide

p: Population controls (total population, population density, etc.)

d: Demographic controls (age, race, gender, etc.)

Time Series Model : Phophet and MLP 

![Prediction of Confirmed Cases In Michi](https://github.com/CindyXin97/MIT_COVID-19_Datathon/blob/master/Results/Prediction%20Confirmed%20Cases%20Num%20in%20Michi.png)
![Prediction of Confirmed Cases In Cali](https://github.com/CindyXin97/MIT_COVID-19_Datathon/blob/master/Results/Prediction%20confirmed_cases%20Number%20in%20Cali.png)

## Results 

![Results](https://github.com/CindyXin97/MIT_COVID-19_Datathon/blob/master/Results/Screen%20Shot%202020-05-16%20at%206.01.59%20PM.png)

Fraction released and county infection rates, with covariate controls
Robust standard errors in parentheses
*** p<0.01, ** p<0.05, * p<0.1

## Policy implications & areas for future research 
Policy Implications 

A better understanding of the relationship between prison release on population health may:

Support policymakers to take the necessary measures to protect communities proximate to prisons

Equip advocacy groups such as the Vera Institute and the ACLU to continue to advocate for policies to reduce the size of prison populations

Help states better manage future disease outbreaks

Areas for Future Research

Dig deeper into the nuances of release policies within states to isolate which policies most effectively reduce incarcerated populations in prisons

Better understand the cost of policies and predict cost-benefit estimates





