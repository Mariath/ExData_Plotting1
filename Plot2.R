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
#choose graphic device and set a file name and setting parameters
png(file="plot2.png", width=480,height=480)
#plotting
with(mydb,plot(Timestamp,Global_active_power,type='l',xlab='',ylab="Global Active Power (kilowatts)"))
#quitting graphic device
dev.off()