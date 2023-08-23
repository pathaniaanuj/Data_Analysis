# load the library
library(tidyverse)
library(ggplot2)
library(dplyr)
library(caTools)
library(RColorBrewer)
# load the movies data in movies name variable
movies<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\raw data\\Movies_dataset.csv")

#checking 1st Five Rows of dataset
head(movies)

#checking rows and columns
dim(movies)
#there are 10,000 Rows and 8 columns in dataset

# Remove unwanted Column 
# Removed 1st and last Row Which is not suitable in our analysis
movies<- movies %>% select(-c(1,8))

# View dataset
view(movies)

#check for missing value in Dataset
sum(is.na(movies))
# there is no missing values in this dataset

#check for duplicate values

movies[duplicated(movies),]

#count how many values are duplicated
count(movies[duplicated(movies),])
# so there are 434 values which are duplicated

# now delete this duplicate values from dataset
movies<-movies[!duplicated(movies),]
# duplicate values are removed

#checking rows and column of dataste
dim(movies)
#now we have 9566 observations and 6 columns

#summary of dataset
summary(movies)
glimpse(movies)

#seperate date column into day , month and year
movies<-separate(movies,release_date,into=c("Day","Month","Year"),sep="-")
view(movies)
#checking data type of day,month and column
typeof(movies$Day)
typeof(movies$Month)
typeof(movies$Year)
#change its data type from character to double
movies$Day<-as.numeric(movies$Day)
movies$Month<-as.numeric(movies$Month)
movies$Year<-as.numeric(movies$Year)

#view data
view(movies)

#there are some movies which will release in future
#it doesn't seem important in our analysis and 
#vote count and vote average of these movies are 0 
#so we delete that columns

#store these value in a variable demo
demo<-movies[(movies$vote_average==0.0 & movies$vote_count==0),]
#so there are 286 rows and 8 column which have vote count and vote average ==0
view(demo)
#checking for NA values
sum(is.na(demo))
#there are 48 missing values

#now remove these rows in existing movies dataset
movies<-movies[!(movies$vote_average==0.0 & movies$vote_count==0),]
#now our data is fully cleaned and its ready for analysis or insight
view(movies)
#now our data has 9280 rows and 8 columns

#find percentage of movies
#average rating  movies which has rating between 4.0 to 7.5
#poor rating movies which has rating between 0.0 to 3.9
#highest rating movies which has rating between 7.6 to 10.0

#count movies language wise
movie_lang_wise<-as.data.frame(table(movies$original_language))
#rename there column name
colnames(movie_lang_wise)<-c("Lang","Total_movies")
#sort the table in descending order
movie_lang_wise<-movie_lang_wise %>% select(everything()) %>%  arrange(-movie_lang_wise$Total_movies)
#view table
view(movie_lang_wise) 

#bar plot movies language wise
movie_lang_wise %>%
        mutate(name = fct_reorder(Lang, Total_movies)) %>%
        ggplot(aes(x=reorder(Lang,Total_movies),Total_movies) )+
        geom_bar(stat="identity", fill="blue", alpha=.9, width=.8,) +
        xlab("Total_number_movies") +
        theme_bw()+coord_flip() 

# create a new column Rating and assign rating name on the basis of vote_average
movies$Rating<-with(movies,ifelse(vote_average >7.4,"High",
                                  ifelse(vote_average >3.9,"Average","Poor")))
view(movies)

# finding percentage of movies on the basis of Rating
#store data in variable according to Rating
High_rating<-subset(movies,Rating=="High")
head(high_rating)

average_rating<-subset(movies,Rating=="Average")
head(average_rating)

poor_rating<-subset(movies,Rating=="Poor")
head(poor_Rating)

#finding percentage
#high rating percentage
Total_movies<-count(movies)
#total movies are 9280

high_rating_percentage<-(count(High_rating)/Total_movies)*100
# 14.87 percentage movies has High rating

# average Percentage
average_rating_percentage<-(count(average_rating)/Total_movies)*100
# 83.79 percentage movies has average Rating

# Poor Rating
poor_rating_percentage<-(count(poor_rating)/Total_movies)*100
# 1.33 Percentage movies has Poor Rating

# Draw pie Chart of Rating Percentage
x<-c("14.87","83.79","1.33")
x<-as.double(x)
labels<-c("High_rating \n14.87%","Average_rating \n83.79%","Poor_rating \n1.33%")
myPalette<-brewer.pal(3,"Set1")
pie(x,labels,main = "Rating Percentage", border = "black",col = myPalette)


