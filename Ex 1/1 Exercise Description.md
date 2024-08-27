1.
Question 1
Instructions
For this assignment we will use data from Lalonde (1986), that aimed to evaluate the impact of  National Supported Work (NSW) Demonstration, which is a labor training program, on post-intervention income levels. Interest is in estimating the causal effect of this training program on income.

First load the packages tableone and Matching:

>install.packages(“tableone”)
>install.packages(“Matching”)
>install.packages("MatchIt")

> library(tableone)
> library(Matching)

Now load the lalonde data (which is in the MatchIt package):
>library(MatchIt)
>  data(lalonde)

The data have n=614 subjects and 10 variables
age age in years. 
educ years of schooling. 
black indicator variable for blacks. 
hispan indicator variable for Hispanics. 
married indicator variable for marital status. 
nodegree indicator variable for high school diploma. 
re74 real earnings in 1974. 
re75 real earnings in 1975. 
re78 real earnings in 1978. 
treat an indicator variable for treatment status.

The outcome is
re78 – post-intervention income.

The treatment is
treat – which is equal to 1 if the subject received the labor training and equal to 0 otherwise.

The potential confounding
variables are: age, educ, black, hispan, married, nodegree, re74, re75.

Question 1
Find the standardized differences for all of the confounding variables (pre-matching). What is the standardized difference for married (to nearest hundredth)?    1 point
A 0.02
B 0.72 <<--aqui!!!
C 0.51
D 0.39

Question 2
What is the raw (unadjusted) mean of real earnings in 1978 for treated subjects minus the mean of real earnings in 1978 for untreated subjects?     1 point
A -$635 <<--aqui!!!
B $219
C $1229
D $1067

Instructions Fit a propensity score model. Use a logistic regression model, where the outcome is treatment. Include the 8 confounding variables in the model as predictors, with no interaction terms or non-linear terms (such as squared terms). Obtain thepropensity score for each subject.

Question 3
What are the minimum and maximum values of the estimated propensity score?    1 point
A minimum=0.009, maximum=0.85  <<--aqui!!!
B minimum=0.188, maximum=0.92
C minimum=0.390, maximum=0.67
D minimum=0.027, maximum=0.81

Instructions
Now carry out propensity score matching using the Match function. Before using the Match function, first do:

>set.seed(931139)

Setting the seed will ensure that you end up with a matched data set that is the same as the one used to create the solutions.
Use options to specify pair matching, without replacement, no caliper. 
Match on the propensity score itself, not logit of the propensity score.  Obtain the standardized differences for the matched data.

Question 4
What is the standardized difference for married?     1 point
A 0.007
B 0.721
C 0.027  <<--aqui!!!
D 0.235

5.
Question 5
For the propensity score matched data: Which variable has the largest standardized difference?     1 point
A age
B black <<--aqui!!!
C nodegree
D re74

Instructions
Re-do the matching, but use a caliper this time. Set the caliper=0.1 in the options in the Match function.
Again, before running the Match function, set the seed:

>set.seed(931139)

Question 6
How many matched pairs are there? 1 point
A 185
B 111 <<--aqui!!!
C 429
D 614

Instructions
Use the matched data set (from propensity score matching with caliper=0.1) to carry out the outcome analysis. 

Question 7
For the matched data, what is the mean of real earnings in 1978 for treated subjects minus the mean of real earnings in 1978 for untreated subjects? 1 point
A $1246.81  <<--aqui!!!
B $903.33
C $499.58 ERRO
D -$629.12

Question 8
Use the matched data set (from propensity score matching with caliper=0.1) to carry out the outcome analysis.
Carry out a paired t-test for the effect of treatment on earnings. What are the values of the 95% confidence interval? 1 point
A ($108.73, $656.21) 
B (-$107.47, $1091.53) ERRO
C ($858.68, $1747.89) ERRO
D (-420.03, 2913.64) <<--aqui!!!