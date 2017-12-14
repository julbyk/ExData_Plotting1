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
png(filename = "plot2.png",width=480, height=480,bg="transparent")

# make the plot
with(data,plot(datetime,Global_active_power,ylab = "Global Active Power (kilowatts)",xlab="",type="l"))

# close png device
dev.off()