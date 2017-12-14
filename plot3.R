library(data.table)
library(lubridate)

#download file
destFile <- "household_power_consumption.txt"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destArc <- "household_power_consumption.zip"
destDir <- getwd()
if(!file.exists(destFile)){
    download.file(fileUrl,destArc)
    unzip(destArc,exdir = destDir)
}

#read data from file
data_raw <- fread(destFile,na.strings = "?")

#select only data with certain dates
data_raw$Date <- dmy(data_raw$Date)
seldat <- ymd(c("2007-02-01","2007-02-02"))
data <- subset(data_raw,data_raw$Date %in% seldat)
rm(data_raw)

datetime <- with(data,strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"))


# open png device
png(filename = "plot3.png",width=480, height=480,bg="transparent")


# make plot sub metering
with(data,plot(datetime,Sub_metering_1,ylab = "Energy sub metering",xlab="",type="l",col="black"))
with(data,lines(datetime,Sub_metering_2,col="red"))
with(data,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)


# close png device
dev.off()