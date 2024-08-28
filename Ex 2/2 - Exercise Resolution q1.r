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
ate_fit <- svyglm(re78~treat, design=weighteddata)
summary(ate_fit)

#%%
m <- summary(ate_fit)
m$coefficients[2,1] + c(-1, 1)*m$coefficients[2,2]*qt(0.975, df=nrow(weighteddata) - 1, lower.tail=FALSE)

#%% Q4 ANSWER
weight <- ifelse(lalonde$treat == 1, 1/(pscore), 1/(1-pscore))

#%%
ddf <- data.frame(lalonde)
ddf$weight <- weight

#%%
design <- svydesign(ids = ~1, data = lalonde, weights = ~weight)

#%%
# Calculate percentiles and truncate weights
weights <- weights(design)

#%%
percentiles <- quantile(weights, c(0.01, 0.99), na.rm = TRUE)
weights_truncated <- pmin(pmax(weights, percentiles[1]), percentiles[2])

#%% Update the survey design object with truncated weights
design_truncated <- update(design, weights = weights_truncated)

#%%
# Fit the model using svyglm
model <- svyglm(re78 ~ treat, design = design_truncated)
summary(model)

#%%
# Compute 95% confidence interval
coef_estimate <- coef(model)['treat']
se_estimate <- summary(model)$coefficients['treat', 'Std. Error']
z_score <- qnorm(0.975)
ci_lower <- coef_estimate - z_score * se_estimate
ci_upper <- coef_estimate + z_score * se_estimate

#%%
# Print results
cat("Estimate of average causal effect:", coef_estimate, "\n")
cat("95% Confidence Interval:", ci_lower, "to", ci_upper, "\n")
