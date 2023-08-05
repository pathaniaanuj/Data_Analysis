library(tidyverse)
library(readxl)
#store data in amazon_sale name variable
amazon_sale<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\amazon_sale_report.csv")
head(amazon_sale)
view(amazon_sale)
# here We rename the variables name
amazon_sale<-amazon_sale %>% select(everything()) %>% rename(order_id=Order.ID,sales_channel=Sales.Channel,ship_service_level=ship.service.level,courier_status=Courier.Status,ship_state=ship.state,ship_city=ship.city,ship_postal_code=ship.postal.code,ship_country=ship.country,fullfilled_by=fulfilled.by)
view(amazon_sale)
# remove unwanted column name which is not useful in our data analysis
amazon_sale<-amazon_sale %>% select(-c(index,SKU,ASIN,promotion.ids,Unnamed..22))
head(amazon_sale)
view(amazon_sale)
#check dim of data
dim(amazon_sale)
#data consists 128975 rows and 19 column

#find na values in this data
sum_na<-sum(is.na(amazon_sale))
sum_na
#there are 7828 NA values this dataset

str(amazon_sale)
#it gives summary of data ..like datatype, mean , length and NA
summary(amazon_sale)
# store NA values in amazon_sale_na variable
amazon_sale_na<- amazon_sale %>% select(everything()) %>% filter(!complete.cases(.))
view(amazon_sale_na)

# remove NA value in Our data
amazon_sale<-amazon_sale %>%  select(everything()) %>% na.omit()
view(amazon_sale)
#check again NA value in our data

sum(is.na(amazon_sale))

#now check for duplicate value

amazon_sale_dupli<-amazon_sale[duplicated(amazon_sale),]
amazon_sale_dupli
dim(amazon_sale_dupli)
#there are only 4 rows which having  duplicate data in our dataset
amazon_sale<-amazon_sale[!duplicated(amazon_sale),]
sum(duplicated(amazon_sale))
#now there is no duplicated value in our data.
#next step seperate date into seperate column having day,month and year variable
View(amazon_sale)
glimpse(amazon_sale)
amazon_sale<-separate(amazon_sale,Date, into = c("month","day","year"))
head(amazon_sale)
view(amazon_sale)
#now change month variable from numeric to as month name
amazon_sale$month<-as.numeric(amazon_sale$month)
amazon_sale$month<-month.abb[amazon_sale$month]
head((amazon_sale$month))
colnames(amazon_sale)
#checking data values 
table(amazon_sale$Status)
table(amazon_sale$courier_status) 
table(amazon_sale$fullfilled_by)
#create a variable and store the existing data
#subsitute the blank space with text in fullfilled_by variable
amazon_sale$fullfilled_by<-  sub("^$","Not Easy",amazon_sale$fullfilled_by)
view(amazon_sale)
#subsitute the blank space in courier_status variable
amazon_sale$courier_status<-  sub("^$","Cancelled",amazon_sale$courier_status)
view(amazon_sale)

# change the data names in ship country / spell check
toupper(amazon_sale)
head(amazon_sale)
write.csv(amazon_sale,"C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\amazon_sale_clean.csv")
library(tidyverse)
amazon_sale<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\amazon_sale_clean.csv")
view(amazon_sale)
#create a new column of total_amount
amazon_sale$total_amount<-amazon_sale$Qty*amazon_sale$Amount
view(amazon_sale)
tail(amazon_sale)
head(amazon_sale)
#remove the data where courier status is cancelled...because cancelled data have 0 quantity
amazon_sale<-amazon_sale[!amazon_sale$courier_status=="Cancelled",]
head(amazon_sale)
view(amazon_sale)
table(amazon_sale$ship_state)
amazon_sale<-select(everything()) %>% toupper(ship_state)
table(amazon_sale$ship_state)
write.csv(amazon_sale,"C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\amazon_sale_clean1.csv")
print("data is cleaned")

