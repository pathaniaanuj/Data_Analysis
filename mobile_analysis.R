library(tidyverse)
mobile<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\Flipkart_Mobiles.csv")
head(mobile)
view(mobile)
# summary of data 
glimpse(mobile)
# there are 3,114 rows and 8 column
summary(mobile)
# it shows 144 N/A values
sum(is.na(mobile))
# it show zero null values in storage column ..but there are some null values
# so now i have to change it datatype char to numeric
sum(is.null(mobile))
colnames(mobile)
# rename the columns
colnames(mobile)[7]<-"Selling_price"
colnames(mobile)[8]<-"Original_price"
view(mobile)

# checking missing values in Rating column
naa<-mobile[is.na(mobile$Rating),]
# there are 144 missing value in rating
count(naa)
view(mobile)

#remove missing values in storage column
mobile<-mobile[!mobile$Storage=="",]
view(mobile)
# remove missing values in memory column
mobile<-mobile[!mobile$Memory=="",]
view(mobile)
# this for checking total selling amount brand wisw
b<- mobile %>% select(c(1,4,5,7)) %>% group_by(Brand) %>%  summarise(Total_Amount=sum(Selling_price)) %>% arrange(-Total_Amount)
view(b)

# remove na values
mobile<- mobile %>%  select(everything()) %>% na.omit()
view(mobile)

# now our data is cleaned 
# save the file for making its visualization

write.csv(mobile,"C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\mobile_clean.csv")
