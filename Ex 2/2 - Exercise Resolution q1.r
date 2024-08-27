#%% 
install.packages("tableone")
install.packages("Matching")
install.packages("ipw")
install.packages("survey")
install.packages("MatchIt")

#%%
library(tableone)
library(Matching)
library(ipw) 
library(survey)
library(MatchIt)

#%%
data(lalonde)

#%%
xvars<-c("age","educ","race","married","nodegree","re74","re75","re78")
print(xvars)

#%%  Propensity Score Matching 
#fit a propensity score model. logistic regression
psmodel<-glm(treat~age+educ+race+married+nodegree+re74+re75+re78, family  = binomial(link ="logit"),data=lalonde)
#show coefficients etc
summary(psmodel)

#%%
## value of propensity score for each subject
pscore <-predict(psmodel, type = "response")
print(pscore)

#%% ?????
#lalonde$pscore <- c(lalonde$treat, pscore)

#END
#%% Created Weights
weight <- ifelse(lalonde$treat == 1, 1/(pscore), 1/(1-pscore))
weighteddata <- svydesign(ids = ~1, data=lalonde, weights = ~weight)
# weighted table 1
weightedtable <- svyCreateTableOne(xvars, strata='treat', data=weighteddata, test=FALSE)

#%%
print(weightedtable, smd=TRUE)

#%% Q1 ANSWER
# Assuming 'weights' is a variable containing the weight values
min_weight <- min(weight)
max_weight <- max(weight)

print(paste("Minimum weight:", min_weight))
print(paste("Maximum weight:", max_weight))

#%% Q2 ANSWER
print(weightedtable, smd=TRUE)

#%% Q3 ANSWER

