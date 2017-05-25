library(sqldf)
library(datasets)

######################################################
# 0A - Obtain the data
######################################################

# Download the data set zip folder if not yet present
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFILE <- "HouseholdConsumption.zip"

if(!file.exists(zipFILE))
  download.file(url = zipURL, destfile = zipFILE)

# Unzip the data if the folder is not yet present
mapFILE <- "HouseholdConsumption"

if(!file.exists(mapFILE))
  unzip(zipfile = zipFILE)

######################################################
# 0B - Read the data
######################################################

# Read the data between 2007-02-01 and 2007-02-02
if(!exists("HouseholdConsumption_days")){
  HouseholdConsumption_days <- read.csv.sql("household_power_consumption.txt",
                                            sql = "select * from file where Date in('1/2/2007','2/2/2007')",
                                            stringsAsFactors = F,sep = ";",header = T)
  completeTime <-strptime(paste(HouseholdConsumption_days$Date, HouseholdConsumption_days$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  HouseholdConsumption_days <- cbind(completeTime,HouseholdConsumption_days)
}

######################################################
# 0B - Create the plot
######################################################

# Create the plot
color_submetering <- c("black","red","blue")
labels_submetering <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")

par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(1,1,1,1))
with(HouseholdConsumption_days,{
  plot(y = Global_active_power,x = completeTime,type = "l",ylab = "Global Active Power",xlab = "")
  plot(y = Voltage,x = completeTime,type = "l")
  plot(y = HouseholdConsumption_days$Sub_metering_1,x = HouseholdConsumption_days$completeTime,col = color_submetering[1],type = "l",ylab = "Energy sub metering",xlab = "")
  lines(y = HouseholdConsumption_days$Sub_metering_2,x = HouseholdConsumption_days$completeTime,col = color_submetering[2])
  lines(y = HouseholdConsumption_days$Sub_metering_3,x = HouseholdConsumption_days$completeTime,col = color_submetering[3])
  legend("topright",bty="n", legend = labels_submetering, col = color_submetering, lty = 1,lwd = 2)
  plot(y = Global_reactive_power,x = completeTime,type = "l")
})
par(mfrow=c(1,1))

# Copy the plot in a PNG file located in the working directory
dev.copy(png, file="plot4.png",width=560)
dev.off()