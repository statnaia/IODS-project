# Irina Statnaia
# 13.11.2021
# Data wrangling script part 1

# Access the dplyr library
library(dplyr)

# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
lrn14

# Look at the dimensions of the data : (183, 60)
dim(lrn14)

# Look at the structure of the data : 'data.frame':	183 obs. of  60 variables
str(lrn14)

# create column 'attitude' by scaling the column "Attitude"
number_of_questions = 10
lrn14$attitude <- lrn14$Attitude / number_of_questions

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
#lrn14$deep

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
#lrn14$surf

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
#lrn14$stra

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
learning2014
str(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)
learning2014
str(learning2014)

write.table(learning2014, file = "learning2014.csv", sep = " ")

lrn14 <- read.csv("D:/Desktop/Courses/Data Science/IODS-project/learning2014.csv", sep=" ", header=TRUE)
lrn14
str(lrn14)
