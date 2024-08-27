#%% First load the packages tableone and Matching:
install.packages(“tableone”)
install.packages(“Matching”)
install.packages("MatchIt")

#%%
library(tableone)
library(Matching)
library(MatchIt)

#%%
data(lalonde)

#%%
#View(lalonde)
#print(colnames(lalonde))

#"treat","age","educ","race","married","nodegree","re74","re75","re78"
#"age","educ","race","married","nodegree","re74","re75","re78"
# age+educ+race+married+nodegree+re74+re75+re78
#%%
xvars <- c("age","educ","race","married","nodegree","re74","re75","re78")

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

# END
#%%  4 - Set.seed + Caliper NULL
set.seed(931139)

#%%
logit <- function(p) {log(p)-log(1-p)}
#%%
pmatch <- Match(Tr = lalonde$treat, M=1, X=logit(pscore), replace=FALSE, caliper=NaN) # nolint: line_length_linter.
matched <- lalonde[unlist(pmatch[c('index.treated', 'index.control')]), ]

#%%
#get standardized differences
matchedtab1<-CreateTableOne(vars=xvars, strata ="treat", data=matched, test = FALSE) 
print(matchedtab1, smd = TRUE) # SMD from married
