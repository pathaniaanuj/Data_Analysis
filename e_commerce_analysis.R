library(tidyverse)
library(readxl)
data<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\e_commerce_data.csv")
view(data)
head(data)
tail(data)
colnames(data)
glimpse(data)
data$InvoiceNo<-as.numeric(data$InvoiceNo)
# count duplicates Rows in dataset
dup1<-count(data[duplicated(data),])
dup2<-count(distinct(data))
dup3<-count(unique(data))
dup4<-count(data[!duplicated(data),])
data1<- data[!duplicated(data),]
view(data1)
summary(data1)
 data1 %>%  select(InvoiceNo) 
 sum(is.na(data1))
 sum(is.na(data$InvoiceNo))
 sum(is.na(data$CustomerID))
NA1<-data1[is.na(data1$InvoiceNo),]
NA2<-data1[is.na(data$CustomerID),]
view(NA1)
view(NA2)

data1<-data1 %>%  select(everything()) %>% na.omit()
view(data1)
# verify Na values in Invoice No
sum(is.na(data1$InvoiceNo))

x<-subset(data1,complete.cases(data1))
data1 <- subset(data1,complete.cases(data1$Country))
glimpse(data1)
data1<-separate(data1,InvoiceDate,into = c("Month","Day","year"),sep = "/")
data1<-separate(data1,year,into = "Year",sep = " ")
view(data1)
data1$Month<-as.numeric(data1$Month)
glimpse(data1)
data1$Day<-as.numeric(data1$Day)
data1$Year<-as.numeric(data1$Year)
glimpse(data1)
view(data1)
data1$Month<-month.abb[data1$Month]
head(data1)

#Now data is cleaned and now its ready to analyze and visulaize
view(data1)
