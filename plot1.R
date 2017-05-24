
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