# import the dataset employe
emp<-read_excel("C:\\Users\\anujr\\OneDrive\\Documents\\data analyst\\employedata.xlsx")
View(emp)
fact<-factor(emp$Department)
table(fact)

# sum of total salary
total_salary<-sum(emp$Annual.Salary)
total_salary
 # calculate bonus amount 
emp$bonnuns_amount<-emp$Annual.Salary*emp$Bonus..
emp$bonnuns_amount

# plus annual salary with bonus amount ..for total salary
emp$salary_plus_bonus<-emp$Annual.Salary+emp$bonnuns_amount
view(emp)

# male data table

male_data<- subset(emp,Gender=="Male")
# female data table
female_data<-subset(emp,Gender=="Female")
# employee having max salary by male and min salary

max_emp_male<-subset(male_data,male_data$Annual.Salary==max(male_data$Annual.Salary))
min_emp_male<-subset(male_data,male_data$Annual.Salary==min(male_data$Annual.Salary))

# employee having max and min salary by female
max_emp_female<-subset(female_data,female_data$Annual.Salary==max(female_data$Annual.Salary))
min_emp_female<-subset(female_data,female_data$Annual.Salary==min(female_data$Annual.Salary))
max_emp_male
max_emp_female
min_emp_female
min_emp_male

# highest salary of employee with detail
highest_salary<-subset(emp,emp$Annual.Salary==max(emp$Annual.Salary))
highest_salary

#lowest salary of employee with detail
lowest_salary<-subset(emp,emp$Annual.Salary==min(emp$Annual.Salary))
lowest_salary

# sum of total bonus amount

total_bonus_amt<-max(emp$bonnuns_amount)
total_bonus_amt

# total sum of annual salary + bonus amount
sum(emp$salary_plus_bonus)


# employee detail having highest bonus
highest_bonus<-subset(emp,emp$bonnuns_amount==max(emp$bonnuns_amount))
highest_bonus

# number of employee by department
no_emp_department<-table(emp$Department)
no_emp_department
view(no_emp_department)

# nomber of employee by country
no_emp_country<-table(emp$Country)
view(no_emp_country)

# number of employee by ethinicity
no_emp_ethincity<-table(emp$Ethnicity)
view(no_emp_ethincity)


# table of older employee
older_emp<-subset(emp,emp$Age==max(emp$Age))
older_emp
view(older_emp)

# table of younger employee
younger_age<-subset(emp,emp$Age==min(emp$Age))
younger_age
view(younger_age)

# sum of total salary according to department and city

city_depart<- emp %>%  group_by(Department,City) %>% 
        summarise(salary_sum=sum(Annual.Salary)
                 )
view(city_depart)

# sum of total salary according to department wise

department_wise<- emp %>% group_by(Department) %>% summarise(Total_salary_departmentwise=sum(Annual_salary))
view(department_wise)

depart_jobtitle<-emp %>% group_by(Department,Job.Title) %>% arrange(emp,Department,Job.Title) %>%   summarise(total_sal=sum(Annual.Salary),.groups = 'drop') 
view(depart_jobtitle)

 clean.name<-clean_names(emp)
print(clean.name)
colnames(clean.name)
view(clean.name)
glimpse(emp)
summary(emp)

n<-emp %>% select(Job.Title,Department,Gender,Ethnicity)%>%  group_by(Gender,Ethnicity) %>% filter(Gender=='Male'& Ethnicity=='Asian') %>%  arrange(Department)
print(n)

write.xlsx("firstanalysiswithR.xlsx")
wrt<-write.csv("FirstanalysisR.csv")
wrt
list.files()

ggplot(department_wise)+geom_point(mapping=aes(x=Department,y=Total_salary_departmentwise,color=Department,size=Department))
library(dplyr)
library(janitor)
library(skimr)
library(magrittr)
library(tidyr)
library(here)
library(ggplot2)
library(tidyverse)library(readxl)

   emp$Annual_salary=emp$`Annual Salary`
  colnames(emp)
  tapply(emp$Annual_salary,emp$Department,sum)
  apply(emp[,"Annual_salary"],2,sum)
sum(Annual_salary)  
sum(emp$Annual_salary)

tapply(emp$Annual_salary,emp$Country,range)
tapply(emp$Annual_salary,emp$Country,sum)
tapply(emp$Annual_salary,emp$Country,mean)
