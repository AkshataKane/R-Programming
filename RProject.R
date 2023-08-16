install.packages("RMySQL")
install.packages("DBI")
library(RMySQL)
library(DBI)
library(dplyr)
mysqlconn=dbConnect(MySQL(),user='root',password='root',dbname='db',host='localhost')
result=dbSendQuery(mysqlconn,"select * from student")
data.frame=fetch(result)
data.frame

#count of students
total_stu<-nrow(data.frame)
total_stu

#data manipulation
data.frame%>%select(FirstName,Age)
data.frame%>%select(starts_with("a"))
data.frame%>%select(ends_with("e"))
data.frame%>%relocate(Age,FirstName)
data.frame%>%rename(Grade=GradeLevel)
data.frame%>%select(matches("(.e.)|(e.)"))
data.frame%>%transmute(full_name = paste(FirstName,LastName))
data.frame%>%filter(Age>16)
data.frame%>%slice(1:7)
data.frame%>%arrange(desc(FirstName))
data.frame%>%top_n(3,GradeLevel)
data.frame%>%count(Age,sort=TRUE)
data.frame%>%summarise(GradeLevel=sum(GradeLevel))
data.frame%>%summarise(GradeLevel=mean(GradeLevel))
data.frame%>%summarise(GradeLevel=median(GradeLevel))
data.frame%>%summarise(GradeLevel=mode(GradeLevel))
data.frame%>%group_by(Age)%>%summarise(n=n())

#Scatter plot
plot(data.frame$Age,data.frame$GradeLevel,xlab = "age",ylab = "grade",col='red')

#Bar plot
barplot(data.frame$GradeLevel,xlab = "names",ylab = "grade",col='pink')

#Histogram
hist(data.frame$Age,xlab = "histplot",col = 'green',border = 'black')

#Pie Chart
pie(data.frame$Age,labels = data.frame$FirstName,col=rainbow(length(data.frame$Age)))

#Line chart
plot(data.frame$Age,type = "o",col='blue')

#Box plot
boxplot(data.frame$GradeLevel,col = 'yellow',main='boxplot')