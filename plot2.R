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
with(HouseholdConsumption_days,plot(y = Global_active_power,x = completeTime,type = "l",ylab = "Global Active Power (kilowatts)",xlab = ""))

# Copy the plot in a PNG file located in the working directory
dev.copy(png, file="plot2.png")
dev.off()