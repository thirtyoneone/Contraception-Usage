log using "C:\Users\vkasa\Desktop\f2.log"
*Tabulating our main variable*
tab v312
*We change the variable such that we remove the people who've never had sex for better results.
replace v312=. if [v312==0 & v364==5]
*New Variable has been created. This variable was created to remove the people who've never had sex from v312.
*Now we create a variable that simply accounts for whether people use contraceptive methods (modern or traditional) or not. It is a nominal variable
gen contra_use=.
replace contra_use=0 if [v312==0]
replace contra_use=1 if [v312>=1 & v312<=18]
label define i_contra_use 0 NO 1 YES
label value contra_use i_contra_use
tab contra_use
tab v312
*Adding weights to the clusters*
gen wt = v005/1000000
svyset v001 [pweight=wt]
*Question 2 : cross tabulation of main variable with other variables*
*religion
svy: tab v312 v130, col
*wealth index
svy: tab v312 v190, col
*highest educational level 
svy: tab v312 v106, col
*type of place of residence Urban/Rural
svy: tab v312 v025, col
*Question 3 : cross tabulation of created nominal variable with same variables as before*
*religion
svy: tab contra_use v130, col
*wealth index
svy: tab contra_use v190, col
*highest educational level 
svy: tab contra_use v106, col
*type of place of residence Urban/Rural
svy: tab contra_use v025, col
gen religion=.
replace religion=0 if v130==1
replace religion=1 if v130==2
replace religion=2 if v130==3
replace religion=3 if v130==4
replace religion=4 if v130==5
replace religion=5 if v130==6
replace religion=6 if v130==7
replace religion=7 if v130==8
replace religion=8 if v130==9
gen urban=.
replace urban=0 if v025==2
replace urban=1 if v025==1
gen wealth=.
replace wealth=0 if v190==1
replace wealth=1 if v190==2
replace wealth=2 if v190==3
replace wealth=3 if v190==4
replace wealth=4 if v190==5
pwcorr contra_use religion ,obs sig
svy: regress contra_use religion
svy: regress contra_use i.religion
pwcorr contra_use wealth ,obs sig
svy: regress contra_use wealth
svy: regress contra_use i.wealth
pwcorr contra_use urban ,obs sig
svy: regress contra_use urban
pwcorr contra_use  v106,obs sig
svy: regress contra_use v106
svy: regress contra_use i.v106
pwcorr contra_use urban religion v106 wealth,obs sig
log using "C:\Users\vkasa\Desktop\aa.log"
pwcorr contra_use religion wealth urban v106,obs sig
svy : reg contra_use religion wealth urban v106
svy : reg contra_use i.religion i.wealth i.urban i.v106
log close
