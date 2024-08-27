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
#xvars <- str(xvars)
#xvars <- any(is.na(xvars))

print(xvars)

#%% 1 - include standardized mean difference (SMD)
#look at a table 1
table1<- CreateTableOne(vars=xvars,strata="treat", data=lalonde, test=FALSE)

#%%
## include standardized mean difference (SMD)
print(table1,smd=TRUE)

## END
