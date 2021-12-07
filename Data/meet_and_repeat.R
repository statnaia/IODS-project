# Irina Statnaia
# 07.12.2021
# This script loads the datasets (BPRS and RATS) and prepares them for analysis

#The datasets (BPRS and RATS) are avilable from the GitHub repository of MABS, where they are given in the wide form:
#https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
#https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

#Load packages
library(dplyr)
library(tidyr)
library(ggplot2)

########################################################################################################################
############################ Download, inspect and prepare the BPRS dataset ############################################
########################################################################################################################

# In the BPRS data 40 male subjects were randomly assigned to one of two treatment groups 
# and each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) 
# and then at weekly intervals for eight weeks. The BPRS assesses the level of 18 symptom constructs such as hostility, 
# suspiciousness, hallucinations and grandiosity; each of these is rated from one (not present) to seven (extremely severe). 
# The scale is used to evaluate patients suspected of having schizophrenia.


#Load the datasets
#setwd("~/IODS-project/data")
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)

#40 observations of 11 variables 

# The data is in wide form : single row contains all data for a single subject
#repetitive measures are saved into multiple variables (week0,..,week8)

# Convert the categorical variables of both data sets to factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

str(BPRS)
#the dataset has now two factor variables

# Convert the dataset to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5,6)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Inspect the modified dataset again 
# Look at the (column) names of BPRS
names(BPRSL)

# Look at the structure of BPRS
str(BPRSL)

# Print out summaries of the variables
summary(BPRSL)

# Number of weeks = 9
# 360 rows, 5 columns, corresponding to treatment, subject, weeks, bprs and week 
# The dataset is now in a long form: a single row contains data only from a single measurement. 
# Repetitive measurement are saved into single variable "bprs" and multiple rows.
# Variable "subject" identifies subject, "week" identifies time. 
# 40 cases x 9 weeks (week 0 + 8 weeks of treatment) = 360 rows. 

# The long form of dataset makes it possible to perform further analysis:
# study the possible diffecences in the bprs value between the treatment groups 
# and the possible change of the value in time

# write the dataset in long form to datafile
write.csv(BPRSL, file = "BPRSL.csv", row.names = FALSE)


########################################################################################################################
############################ Download, inspect and prepare the RATS dataset ############################################
########################################################################################################################

# Data from a nutrition study conducted in three groups of rats. The groups were put on different diets, 
# and each animal’s body weight (grams) was recorded repeatedly (approximately) weekly, except in week seven 
# when two recordings were taken) over a 9-week period.

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of RATS
names(RATS)

# Look at the structure of RATS
str(RATS)

# Print out summaries of the variables
summary(RATS)

#16 observations of 13 variables 

# The data is in wide form : single row contains all data for a single subject
#repetitive measures are saved into multiple variables (WD1,..,WD64)

# Convert the categorical variables of both data sets to factors.
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

str(BPRS)
#the dataset has now two factor variables

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Inspect the modified dataset again 
# Look at the (column) names of BPRS
names(RATSL)

# Look at the structure of BPRS
str(RATSL)

# Print out summaries of the variables
summary(RATSL)

# Glimpse the data
glimpse(RATSL)

# Number of levels in Time = 11
# 176 observations of 5 variables
# This is a long form data: single row contains data only from a single measurement. 
# Repetitive measurement are saved into single variable "Weight" and multiple rows.
# Variable "ID" identifies subject, "Time" identifies time (in days). 
# 16 cases x 11 observation times = 176 rows. 

# The long form of dataset makes it possible to perform further analysis:
# study the possible diffecences in the rats value between the treatment groups 
# and the possible change of the value in time

# write the dataset in long form to datafile
write.csv(RATSL, file = "RATSL.csv", row.names = FALSE)

