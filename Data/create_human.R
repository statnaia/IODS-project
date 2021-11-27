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
write.csv(human,'human.csv', row.names = FALSE)



