# Remove all objects from R
rm(list = ls())

# Set working directory
setwd("C:/Users/admin/Documents/R files")

# load library
library(mongolite)

# Connect to local mongo db and create a collection test within a database mtcars
channel = mongo(collection = "test", db = "mtcars", url = "mongodb://localhost:27017")

# Returns collection status
print(channel$info())

# load dataframe in R environment
df <- read.csv("mtcars.csv",sep = ",",header = T)

# data in the form of character vector with JSON strings
str <- c('{"name" : "jerry"}' , '{"name": "anna", "age" : 23}', '{"name": "joe"}')

#Store data in MongoDB using insert query
#it's syntax is insert(data, pagesize = 1000, stop_on_error = TRUE, ...)
# data can be dataframe or character vectors with JSON strings
# so to store data which is in the form of character vectors with JSON strings
channel$insert(data = str)

channel$count() == nrow(str)

#extract the data from collection using find
channel$find(query = '{}',limit = 5)

# removing stored data 
channel$remove(query='{}')

# now store data which is in the form of Dataframe
channel$insert(data = df)

#now let us verify all our data  was inserted
#below query returns boolean, TRUE means data was inserted and FALSE means not
channel$count() == nrow(df)# for Dataframe


#extract the data from collection using find
channel$find(query = '{}',limit = 5)

# Disconnect database
channel$disconnect(gc = TRUE)
