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

MyDataSet=household_power_consumption

# converting the Date and Time variables to Date/Time classes
MyDataSet$Date=as.Date(MyDataSet$Date,"%d/%m/%Y") 
MyDataSet$Time=strptime(x = paste( MyDataSet$Date,MyDataSet$Time), format = "%Y-%m-%d %H:%M:%S")


# Plot 2: Global Active Power variation over the two days
Sys.setlocale("LC_ALL", "English") # set days labels in english 
with(MyDataSet, plot(x= Time,y = Global_active_power,
                     type = "l",xlab= "",
                     ylab= "Global Active Power (kilowatts)"))
#  saving plot 2 into a png file
dev.copy(png,file="plot2.png",units="px",width = 480, height = 480)
dev.off()

