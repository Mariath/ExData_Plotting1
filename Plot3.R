#set working directory where the file is located

setwd('./exdata%2Fdata%2Fhousehold_power_consumption')
file<-'household_power_consumption.txt'


#load dataset to R
powert<-read.table(file,head=TRUE, sep=';')

#load dataset to R
powert<-read.table('household_power_consumption.txt',head=TRUE, sep=';')
#creating a new column with Data and Time converted to Date class
powert$Timestamp <- strptime(paste(powert$Date, powert$Time), "%d/%m/%Y %H:%M:%S")
#converting Date column to Date class
powert$Date<-as.Date(powert$Date,"%d/%m/%Y")
#subsetting information that relates to the needed dates
mydb<-powert[powert$Date=='2007-02-01' | powert$Date=="2007-02-02",]
mydb$Sub_metering_1<-as.numeric(as.character(mydb$Sub_metering_1))
mydb$Sub_metering_2<-as.numeric(as.character(mydb$Sub_metering_2))
mydb$Sub_metering_3<-as.numeric(as.character(mydb$Sub_metering_3))

#choose graphic device and set a file name and setting parameters
png(file="plot3.png", width=480,height=480)
#plotting
with(mydb,{plot(Timestamp,Sub_metering_1,type='l',xlab='',ylab="Global Active Power (kilowatts)")
  lines(Timestamp,Sub_metering_2, col='red')
  lines(Timestamp,Sub_metering_3,col='blue')})
#setting the legend parameters
legend('topright',col=c('black','red','blue'),lty=c(1,1),lwd=c(1,1),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
#quitting graphic device
dev.off()