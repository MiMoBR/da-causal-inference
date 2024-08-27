Instructions 
For this assignment we will use data from Lalonde (1986),
that aimed to evaluate the impact of  National
Supported Work (NSW) Demonstration, which is a labor training program, on post-intervention
income levels. Interest is in estimating the causal effect of this training
program on income.

First load the packages TableOne, Matching, ipw, and survey:

install.packages(“tableone”)
install.packages(“Matching”)
install.packages(“ipw”)
install.packages(“survey”)
install.packages("MatchIt")

library(tableone)
library(Matching)
library(ipw) 
library(survey)

Now load the lalonde data (which is in the MatchIt package):

library(MatchIt)
data(lalonde)

The data have n=614 subjects and 10 variablesage age in years. 
educ years of schooling. 
black indicator variable for blacks. 
hispan indicator variable for Hispanics. 
married indicator variable for marital status. 
nodegree indicator variable for high school diploma. 
re74 real earnings in 1974. 
re75 real earnings in 1975. 
re78 real earnings in 1978. 
treat an indicator variable for treatment status.

The outcome is re78 – post-intervention income.
The treatment is treat – which is equal to 1 if the subject received the labor training and equal to 0 otherwise.

The potential confounding variables are: age, educ, black, hispan, married, nodegree, re74, re75.

Fit a propensity score model. Use a logistic regression
model, where the outcome is treatment. Include the 8 confounding variables in
the model as predictors, with no interaction terms or non-linear terms (such as
squared terms). Obtain the propensity score for each subject. Next, obtain the
inverse probability of treatment weights for each subject.

Question 1
What are the minimum and maximum weights?     1 point
A 1.01 and 40.1  << aqui >>
B 0.20 and 178.2
C 0.44 and 955.8
D 0.009 and 0.85


Question 2
Find the standardized differences for each confounder on the weighted (pseudo) population. What is the standardized difference for nodegree?     1 point
A 0.11 <<--aqui!!!
B 0.57
C 0.62
D 0.05


Question 3
Using IPTW, find the estimate and 95% confidence interval for the average causal effect. This can be obtained from svyglm 1 point
A Est: 575.40   95% CI: (-201.23, 1339.74)
B Est: 984.11   95% CI: (151.87, 1582.49)
C Est: -342.24   95% CI: (-719.04, 51.88)
D Est: 224.68 95% CI: (-1559.32, 2008.67)  <<--aqui!!!


Instructions
Now truncate the weights at the 1st and 99th percentiles. This can be done with the trunc=0.01 option in svyglm. 

Questions 4
Using IPTW with the truncated weights, find the estimate and 95% confidence interval for the average causal effect. 1 point
A -105.56 (-909.32, 755.17)
B 486.93  (-1090.64, 2064.51)  <<--aqui!!!
C 291.62 (-898.13, 1202.79)
D 1040.87 (121.82, 2171.04)