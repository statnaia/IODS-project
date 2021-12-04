# Irina Statnaia
# 27.11.2021
# This script creates Human Development Index (HDI) dataset


# The Human Development Index (HDI) dataset originates from the United Nations Development Programme.
# The Human Development Index (HDI) is a summary measure of average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living.
# The HDI is the geometric mean of normalized indices for each of the three dimensions.

# Read data form source: Human development and Gender inequality
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore the datasets: structure, dimensions and summaries of the variables

# Dataset Human development
str(hd)       # 195 obs. of  8 variables
dim(hd)       # 195   8
summary(hd)   # all variables have different scales
colnames(hd)

# [1] "HDI.Rank"                               "Country"                               
# [3] "Human.Development.Index..HDI."          "Life.Expectancy.at.Birth"              
# [5] "Expected.Years.of.Education"            "Mean.Years.of.Education"               
# [7] "Gross.National.Income..GNI..per.Capita" "GNI.per.Capita.Rank.Minus.HDI.Rank" 


# Dataset Gender inequality
str(gii)      # 195 obs. of  10 variables
dim(gii)      # 195  10
summary(gii)  # all variables have different scales
colnames(gii)

# [1] "GII.Rank"                                     "Country"                                     
# [3] "Gender.Inequality.Index..GII."                "Maternal.Mortality.Ratio"                    
# [5] "Adolescent.Birth.Rate"                        "Percent.Representation.in.Parliament"        
# [7] "Population.with.Secondary.Education..Female." "Population.with.Secondary.Education..Male."  
# [9] "Labour.Force.Participation.Rate..Female."     "Labour.Force.Participation.Rate..Male." 

# Renaming the columns of datasets with shorter names

colnames(hd)[1] <- "HDI_rank"
colnames(hd)[2] <- "Country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LifeExp"
colnames(hd)[5] <- "EdExp"
colnames(hd)[6] <- "EdMean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI_m_HDI"

colnames(hd)

colnames(gii)[1] <- "GII_rank"
colnames(gii)[2] <- "Country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MatMortality"
colnames(gii)[5] <- "TeenBirthRate"
colnames(gii)[6] <- "ParlPerc"
colnames(gii)[7] <- "Edu2_f"
colnames(gii)[8] <- "Edu2_m"
colnames(gii)[9] <- "Lab_f"
colnames(gii)[10] <- "Lab_m"

colnames(gii)

# Mutation of the “Gender inequality” data and creation two new variables (ratios of two variables).
library(dplyr)
gii <- mutate(gii, edu_ratio = Edu2_f/Edu2_m)
gii <- mutate(gii, lab_ratio = Lab_f/Lab_m)

#Joining the two datasets using the variable Country as the identifier. 
human <- inner_join(hd, gii, by="Country")
dim (human)  # 195  19

# Write csv file
write.csv(human,'human_1step.csv', row.names = FALSE)


########################################### PART TWO 05.12.2021 #####################################

# The dataset used in this part is the same dataset described above, but now it contains combined “Human development” 
# and “Gender inequality” data. Moreover, the variables are given new shorter names. The Education and Labour force data for males 
# and females are mutated as ratios of these two parameters. The dataset  contains 195 observations in 19 different variables.

#"Country" = Country name

#"GNI" = Gross National Income per capita
#"LifeExp" = Life expectancy at birth
#"EdExp" = Expected years of schooling 
#"MatMortality" = Maternal mortality ratio
#"TeenBirthRate" = Adolescent birth rate
#"HDI_rank" = HDI.Rank
#"HDI" = Human.Development.Index..HDI.
#"EdMean" = Mean.Years.of.Education
#"GNI_m_HDI" = GNI.per.Capita.Rank.Minus.HDI.Rank
#"GII_rank" = GII.Rank
#"GII" = Gender.Inequality.Index..GII.
#"ParlPerc" = Percent.Representation.in.Parliament
#"Edu2_f" = Proportion of females with at least secondary education
#"Edu2_m" = Proportion of males with at least secondary education
#"Labo_f" = Proportion of females in the labour force
#"Labo_m" " Proportion of males in the labour force

#"edu_ratio" = Edu2_f / Edu2_m
#"lab_ratio" = Labo2_f / Labo2_m

# read the dataset from a file created a step before 
human <- read.csv("./human_1step.csv")

# check the dimensions
dim (human)    # 195  19

# look at the (column) names of human
names(human)

#[1] "HDI_rank"      "Country"       "HDI"           "LifeExp"       "EdExp"         "EdMean"        "GNI"           "GNI_m_HDI"    
#[9] "GII_rank"      "GII"           "MatMortality"  "TeenBirthRate" "ParlPerc"      "Edu2_f"        "Edu2_m"        "Lab_f"        
#[17] "Lab_m"         "edu_ratio"     "lab_ratio"

# look at the structure of human
str(human)

#'data.frame':	195 obs. of  19 variables:
#$ HDI_rank     : int  1 2 3 4 5 6 6 8 9 9 ...
#$ Country      : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
#$ HDI          : num  0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
#$ LifeExp      : num  81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
#$ EdExp        : num  17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
#$ EdMean       : num  12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
#$ GNI          : chr  "64,992" "42,261" "56,431" "44,025" ...
#$ GNI_m_HDI    : int  5 17 6 11 9 11 16 3 11 23 ...
#$ GII_rank     : int  1 2 3 4 5 6 6 8 9 9 ...
#$ GII          : num  0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
#$ MatMortality : int  4 6 6 5 6 7 9 28 11 8 ...
#$ TeenBirthRate: num  7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
#$ ParlPerc     : num  39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
#$ Edu2_f       : num  97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
#$ Edu2_m       : num  96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
#$ Lab_f        : num  61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
#$ Lab_m        : num  68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...
#$ edu_ratio    : num  1.007 0.997 0.983 0.989 0.969 ...
#$ lab_ratio    : num  0.891 0.819 0.825 0.884 0.829 ...

# print out summaries of the variables
summary(human)

# Gross National Income (GNI) variable transformation to numeric

# access the stringr package
library(stringr)

# remove the commas from GNI and replace it with a numeric version
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)
glimpse(human)
#Commas are gone, variable is now numeric

# Exclude variables that we do not need
# columns to keep
keep <- c('Country', 'edu_ratio', 'lab_ratio', 'EdExp', 'LifeExp', 'GNI', 'MatMortality', 'TeenBirthRate', 'ParlPerc')

# select the 'keep' columns
human <- select(human, one_of(keep))
glimpse(human)
#Rows: 195
#Columns: 9

# Remove all rows with missing values

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))
complete.cases(human_)
# now it is complete

# Remove the observations which relate to regions instead of countries.

# look at the last 10 observations of human
tail(human_, n = 10)

# define the last indice we want to keep - all but last 7 rows
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human <- human_[1:last, ]
tail(human, n = 10)
# no more regions in the dataset

# add countries as rownames
rownames(human) <- human$Country

#remove variable country
human <- select(human, -Country)

dim(human)  #[1] 155   8

#save the data with row names
write.csv(human, "human.csv", row.names=TRUE)



