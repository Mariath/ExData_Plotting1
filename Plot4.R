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

#converting columns from factor to character and finally numeric to 
#be able to use it for plots and histograms 
mydb$Global_active_power<-as.numeric(as.character(mydb$Global_active_power))
mydb$Sub_metering_1<-as.numeric(as.character(mydb$Sub_metering_1))
mydb$Sub_metering_2<-as.numeric(as.character(mydb$Sub_metering_2))
mydb$Sub_metering_3<-as.numeric(as.character(mydb$Sub_metering_3))
mydb$Voltage<-as.numeric(as.character(mydb$Voltage))
mydb$Global_reactive_power<-as.numeric(as.character(mydb$Global_reactive_power))


#choose graphic device and set a file name and setting parameters
png(file="plot4.png", width=480,height=480)
#setting the screen parameters
par(mfrow=c(2,2), mar=c(4, 4, 2, 2))
#plotting the first plot
with(mydb,plot(Timestamp,Global_active_power,type='l',xlab='',ylab="Global Active Power (kilowatts)"))
#plotting the second plot
with(mydb,plot(Timestamp,Voltage,type='l',xlab='datetime',ylab="Voltage"))
#plotting the third plot
with(mydb,{plot(Timestamp,Sub_metering_1,type='l',xlab='',ylab="Global Active Power (kilowatts)")
  lines(Timestamp,Sub_metering_2, col='red')
  lines(Timestamp,Sub_metering_3,col='blue')})
#setting the legend
legend('topright',col=c('black','red','blue'),lty=c(1,1),lwd=c(1,1),bty='n',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
#plotting the last plot
with(mydb,plot(Timestamp,Global_reactive_power, type='l',xlab='datetime',ylab='Global_reactive_power'))
#quitting graphic device
dev.off()
