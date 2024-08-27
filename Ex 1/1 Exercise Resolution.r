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

#%% 1 - include standardized mean difference (SMD)
#look at a table 1
table1<- CreateTableOne(vars=xvars,strata="treat", data=lalonde, test=FALSE)

#%%
## include standardized mean difference (SMD)
print(table1,smd=TRUE)

## END
#%% 2 - Do Greedy Matching on Mahalanobis distance
greedymatch<-Match(Tr=lalonde$treat,M=1,X=lalonde[xvars],replace=FALSE)
#%%
matched<-lalonde[unlist(greedymatch[c("index.treated","index.control")]), ]

#%%
typeof(lalonde$treat)

## END
#%%  3 - Propensity Score Matching 
#fit a propensity score model. logistic regression
psmodel<-glm(treat~age+educ+race+married+nodegree+re74+re75+re78, family=binomial(),data=lalonde)
#show coefficients etc
summary(psmodel)
#%%
#create propensity score
pscore<-psmodel$fitted.values
print(pscore)

#%%  4 - MIN and MAX
# Assuming you have a vector named 'propensity_scores' containing the estimated propensity scores
min_propensity <- min(pscore)
max_propensity <- max(pscore)

# Print the results
print(paste("Minimum propensity score:", min_propensity))
print(paste("Maximum propensity score:", max_propensity))

#%%  5 - Set.seed + Caliper - Question 7
set.seed(931139)

#%%
#do greedy matching on logit(PS) using Match with a caliper
logit <- function(p) {log(p)-log(1-p)}
psmatch<-Match(Tr=lalonde$treat,M=1,X=logit(pscore),replace=FALSE,caliper=.1) ## caliper=NULL
matched<-lalonde[unlist(psmatch[c("index.treated","index.control")]), ]
#%%
#get standardized differences
matchedtab1<-CreateTableOne(vars=xvars, strata ="treat", 
                            data=matched, test = FALSE)
print(matchedtab1, smd = TRUE)

#%%
# Assuming 'treat' is the treatment variable and 're78' is real earnings in 1978
treated_data <- matched[matched$treat == 1, ]
untreated_data <- matched[matched$treat == 0, ]

mean_treated_earnings <- mean(treated_data$re78)
mean_untreated_earnings <- mean(untreated_data$re78)

difference <- mean_treated_earnings - mean_untreated_earnings
print(difference)

#%% 6 - T-Test
#do greedy matching on logit(PS) using Match with a caliper
logit2 <- function(p) {log(p)-log(1-p)}
psmatch<-Match(Tr=lalonde$treat,M=1,X=logit2(pscore),replace=FALSE,caliper=.1)
matched3<-lalonde[unlist(psmatch[c("index.treated","index.control")]), ]
#%%
#get standardized differences
matchedtab3<-CreateTableOne(vars=xvars, strata ="treat", 
                            data=matched3, test = FALSE)
print(matchedtab3, smd = TRUE)

#%%
print(matchedtab3)

#%%
print(matched3)

#%%
#outcome analysis
y_trt<-matched3$treat==1
y_con<-matched3$treat==0

#%%
print(y_trt)
print(y_con)

#%%
#pairwise difference
diffy<-y_trt-y_con
print(diffy)

#%%
#paired t-test
t.test(diffy)

#%%
print(matched3)
#%%
# Assuming 'treat' is the treatment variable and 're78' is real earnings in 1978
treated_data1 <- matched3[matched3$treat == 1, ]
untreated_data1 <- matched3[matched3$treat == 0, ]
print(treated_data1)
print(untreated_data1)
#%%
mean_treated_earnings1 <- mean(treated_data1$re78)
mean_untreated_earnings1 <- mean(untreated_data1$re78)
print(mean_treated_earnings1)
print(mean_untreated_earnings1)
#%%
difference1 <- mean_treated_earnings1 - mean_untreated_earnings1
print(difference1)
print(mean_treated_earnings1 - mean_untreated_earnings1)

#%% question 8

# Assuming 're78_treated' and 're78_control' are the columns for earnings
diffy1 <- treated_data1$re78 - untreated_data1$re78
print(diffy1)
#%%
t_test_result <- t.test(diffy, paired = TRUE)

# Print the results
print(t_test_result)


#%%
y_trt<-matched3$treat==1
y_con<-matched3$treat==0

#%%
print(y_trt)
print(y_con)

#%%
#pairwise difference
diffy<-y_trt-y_con
print(diffy)

#%%
#paired t-test
t.test(diffy)

#%%
print(matched3)