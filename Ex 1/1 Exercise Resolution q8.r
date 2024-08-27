#%% First load the packages tableone and Matching:
install.packages(“tableone”)
install.packages(“Matching”)
install.packages("MatchIt")

#%%
library(tableone)
library(Matching)

#%%
library(MatchIt)

#%%
data(lalonde)

#%%
View(lalonde)

#%%
print(colnames(lalonde))

#"treat","age","educ","race","married","nodegree","re74","re75","re78"
#"age","educ","race","married","nodegree","re74","re75","re78"
# age+educ+race+married+nodegree+re74+re75+re78
#%%
xvars<-c("age","educ","race","married","nodegree","re74","re75","re78")
print(xvars)

#%%  3 - Propensity Score Matching 
#fit a propensity score model. logistic regression
psmodel<-glm(treat~age+educ+race+married+nodegree+re74+re75+re78, family=binomial(),data=lalonde)
#show coefficients etc
summary(psmodel)
#%%
#create propensity score
pscore<-psmodel$fitted.values
print(pscore)

#%%
#do greedy matching on logit(PS) using Match with a caliper
logit <- function(p) {log(p)-log(1-p)}
psmatch<-Match(Tr=lalonde$treat,M=1,X=logit(pscore),replace=FALSE,caliper=.1)
matched<-lalonde[unlist(psmatch[c("index.treated","index.control")]), ]

#%%
#get standardized differences
matchedtab<-CreateTableOne(vars=xvars, strata ="treat", 
                            data=matched, test = FALSE)
print(matchedtab, smd = TRUE)

#%%
# Assuming 'treat' is the treatment variable and 're78' is real earnings in 1978
treated_data <- matched[matched$treat == 1, ]
untreated_data <- matched[matched$treat == 0, ]
print(treated_data)

#%%
re78_treated <- treated_data$re78
re78_untreated <- untreated_data$re78

#%%
# Assuming 're78_treated' and 're78_control' are the columns for earnings
diffy <- re78_treated - re78_untreated

#%%
print(t.test(diffy))

