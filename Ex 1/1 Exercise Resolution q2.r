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

#%%
head(lalonde[xvars])
#print(xvars)

#%%
str(lalonde[xvars])
print(lalonde[xvars])

#%%
a <- lalonde[lalonde$treat==1,]re78
print(a)

#%%
mean(lalonde[lalonde$treat==1,]re78) - mean(lalonde[lalonde$treat==0,]re78)


#%% 2 - Do Greedy Matching on Mahalanobis distance
greedymatch <- Match(Tr = lalonde$treat, M = 1, X = lalonde[xvars], replace = FALSE)

#%%
matched<-lalonde[unlist(greedymatch[c("index.treated","index.control")]), ]

#%%
typeof(lalonde$treat)

## END
#%%
