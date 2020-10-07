# The dataset has 2,075,259 rows and 9 columns. 
# First we calculate a rough estimate of how much memory the dataset 
# will require in memory before reading into R
# rough estimate of memory required = no. of column * no. of rows * 8 bytes/numeric
# 2075259*9*8
# 149418648 bytes
# 149418648/2^20 MB
# 142.4967 MB
# 142.4967*2^(-10) GB
# ~ 0.13 GB
# ok for reading data (computer has enough memory)


# Reading and saving data

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE, sep=";", na.strings="?")
unlink(temp)


#Filtering data from the dates 2007-02-01 and 2007-02-02.
library(dplyr)
names(data)
household_power_consumption=filter(data,Date %in% c('1/2/2007','2/2/2007'))
# saving data in working directory
write.table(household_power_consumption,file = "household_power_consumption.txt",row.names = FALSE)


MyDataSet=household_power_consumption

# converting the Date and Time variables to Date/Time classes
MyDataSet$Date=as.Date(MyDataSet$Date,"%d/%m/%Y") 
MyDataSet$Time=strptime(x = paste( MyDataSet$Date,MyDataSet$Time), format = "%Y-%m-%d %H:%M:%S")

names(MyDataSet)
Sys.setlocale("LC_ALL", "English") # set days labels in english 
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))

# Plot 4: how household energy usage varies over a 2-day period in February
# plot4.1:Global Active Power variation over the two days
with(MyDataSet, plot(x= Time,y = Global_active_power,
                     type = "l",xlab= "",
                     ylab= "Global Active Power"))
# plot4.2:Voltage variation over the two days
with(MyDataSet, plot(x= Time,y = Voltage,
                     type = "l",xlab= "Datetime"))
# plot4.3:variation of the 3 energy sub-metering  over the two days
with(MyDataSet, plot(x= Time,y = Sub_metering_1,
                     type = "l",col="black",
                     xlab= "",
                     ylab= "Energy sub metering"))
with(MyDataSet, points(x= Time,y = Sub_metering_2, type = "l",col="red"))
with(MyDataSet, points(x= Time,y = Sub_metering_3, type = "l",col="blue"))
legend(x="topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","red","blue"),cex=0.7,
       bty="n",
       xjust=1)



# plot4.4:Global_reactive_power variation over the two days
with(MyDataSet, plot(x= Time,y = Global_reactive_power,
                     type = "l",xlab= "Datetime"
                     ))
#  saving plot 4 into a png file
dev.copy(png,file="plot4.png",units="px",width = 480, height = 480)
dev.off()


