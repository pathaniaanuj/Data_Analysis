library(readr)
library(tidyverse)
library(dplyr)
library(janitor)
library(magrittr)
library(skimr)
library(here)
library(tidyr)
library(ggplot2)
library(readxl)

dataset<-read.csv("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\ab dev analysis\\abdev.csv")
view(dataset)
colnames(dataset)
table(dataset$Against)
class(dataset$Score)='Numeric'
dataset<-dataset %>% mutate(Score= gsub("\\*"," ",Score))
class(dataset$Score)
view(dataset)
dataset <- dataset %>% mutate(Score=as.numeric(Score))

#tsaet = total score against each team
tsaet<-dataset %>%  select(Against,Score) %>% group_by(Against) %>% 
        summarize(total_score=sum(Score)) %>% arrange(total_score)
view(dataset)
view(tsaet)
str(dataset)
summary(dataset)
print(tsaet)
class(tsaet)
glimpse(tsaet)
ggplot(tsaet,aes(x=Against,y=total_score,color=Against,fill=Against,width=0.5))+geom_bar(stat = "identity")
 #match played against each team
MPAET<- dataset %>% select(Against,Innings) %>% group_by(Against) %>%  summarize(total_match_played=sum(Innings)) %>% arrange(-total_match_played)
view(MPAET)

home<-dataset %>% filter(Ground=="Home")
away<-dataset %>% filter(Ground=="Away")
Neutral<-dataset %>% filter(Ground=="Neutral")
print(Neutral)
print(home)
view(home)
print(away)
view(away)
#for winning percent we take a variable of number of total_match,home_match and Away_match
 total_match<-47
 # all about home
 
 home_match<-22
 won_in_home<- as.numeric(nrow(home[home$Result=='Won',]))
 won_in_home
 lost_in_home<- as.numeric(nrow(home[home$Result=='Lost',]))
 draw_in_home<- as.numeric(nrow(home[home$Result=='Drawn',]))
 no_result<- as.numeric(nrow(home[home$Result=='No result',]))
 lost_in_home
 draw_in_home
 no_result
 
 away_match<-18
 Neutral_match<-7
 
winning_percent_home<-won_in_home/home_match*100
lossing_percent_home<-lost_in_home/home_match*100
drawn_percent_home<-draw_in_home/home_match*100

#winning percentage away 
table(away$Result)
library(stringr)
dataset$Result <- str_replace(dataset$Result,"Won D/L","Won")
dataset$Result <- gsub("D/L"," ",dataset$Result)
view(away)
view(dataset)
table(away$Result)

str(away)
summary(away)

home_away<- dataset %>% select(Ground,Score) %>% group_by(Ground) %>% summarize(total_score_ground=sum(Score))
home_away %>% 
ggplot(home_away,mapping=aes(x=Ground,y=total_score_ground,color=Ground,fill=Ground))+geom_bar(stat="identity")

max_score<-subset(dataset,dataset$Score==max(Score))
min_score<-subset(dataset,dataset$Score==min(Score))
max_score
min_score

position_score<- dataset %>% select(Position,Score) %>% group_by(Position) %>% summarize(total_score_position=sum(Score)) 
        ggplot(position_score,mapping=aes(x=Position,y=total_score_position,fill=Position))+geom_bar(stat = "identity")
print(position_score)

write.csv(dataset,"C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\ab_dev_analysis.csv")
print("analysis is completed")
write.csv(dataset,"C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\ab dev analysis\\dev.csv")
