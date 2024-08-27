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
psmatch7<-Match(Tr=lalonde$treat,M=1,X=logit(pscore),replace=FALSE,caliper=.1)
matched7<-lalonde[unlist(psmatch7[c("index.treated","index.control")]), ]

#%%
print(matched7)
#%%
treated7 <- matched7[matched7$treat == 1,]$re78 #treated
untreated7 <- matched7[matched7$treat == 0,]$re78 # control
print(treated7)
print(untreated7)
#%%
q7 <- mean(treated7) - mean(untreated7)
print(q7)

#%%
#%%
treated7 <- matched7[matched7$treat == 1, c('re78 ')] #treated
untreated7 <- matched7[matched7$treat == 0, c('re78 ')] # control



#%%
q88 <- t.test(treated7,untreated7, conf.level = 0.95, paired=TRUE)
print(q88)
#%%
tbone <- CreateTableOne(vars=xvars, strata='treat', data=matched7, test=TRUE)