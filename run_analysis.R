library(data.table) #load library necessray for melt and dcast

#1 : merge all the observations fromt est and training  in one data set 
#load the  observations stored in X_test and x_train.txt 

trainx<-read.table(paste0(getwd(),"/train/X_train.txt"))
testx<-read.table(paste0(getwd(),"/test/X_test.txt"))
x<-rbind(trainx,testx)
#load the  activities identified for the  observations  
traina<- read.table(paste0(getwd(),"/train/Y_train.txt"))
testa<-read.table(paste0(getwd(),"/test/Y_test.txt"))
a<-rbind(traina,testa)
colnames(a)<-"Activity"
#load the subjects identified for the observations
trains<-read.table(paste0(getwd(),"/train/subject_train.txt"))
tests<-read.table(paste0(getwd(),"/test/subject_test.txt"))
s<-rbind(trains,tests)
colnames(s)<-"Subject"
x<-cbind(s,a,x) #final complete dataset is in x with subject, activities and the 561 variables

#2 keep only variable mean and std

var<-read.table("features.txt", stringsAsFactors = FALSE)
var2<-var[grepl("mean\\(\\)",var$V2) |grepl("std\\(\\)",var$V2), ] #var2=id and descriptions of the columns that must be kept
x<-x[,c(1,2,var2$V1+2)] #keep columns 1 and 2 that contains subject and activity + the columns selected in the previous step


#3 Use descriptive activity names to name the activities in the dataset - this is done via a simple merge
al<-read.table("activity_labels.txt", stringsAsFactors = FALSE)
colnames(al)<-c("Activity", "Activity_label")
x<-merge(x,al,by="Activity",suffixes=c(".x",".y"))

#4:  labels the dataset with descriptive variable names. As the names of the variables that must kept were stored in vector
#var2, we just rename the columns starting from 3 with this vector.
colnames(x)[3:(ncol(x)-1)] <- var2$V2


#5 : produce the data set with average of each variable by activity and subject
#melting to produce a ds with key Activity + subject, variable = the measures of x 
#(the value containing the value of the variables)

xmelt<-melt(x,id=c("Activity_label","Subject"),measure.vars=c(3:(ncol(x)-1)))
#using dcast to product a ds with the averages (mean) of each variable for activity and subject
tidyds<-dcast(xmelt,Activity_label+Subject ~ variable, fun=mean)
write.table(tidyds,"tidyds.txt", row.names = FALSE)
          
