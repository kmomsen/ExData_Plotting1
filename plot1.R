#----------------------------------------------------
# Install packages and load libraries
#----------------------------------------------------
install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)

#----------------------------------------------------
# Set data file location & download file
#----------------------------------------------------
zipfileloc <- "C:/temp/UCI Electric Power Consumption.zip"
unzipfileloc <- "C:/temp"
dir.create(unzipfileloc)

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfile, zipfileloc)
unzip(zipfileloc, exdir = unzipfileloc)

setwd(unzipfileloc)

#----------------------------------------------------
# Load data into R and subset data to 1 Feb 2007 
#   through 2 Feb 2007
#----------------------------------------------------
data <- read.delim(paste0(unzipfileloc,"/household_power_consumption.txt"), header = TRUE, sep = ";")

febdata <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")
febdata$datetime <- paste(febdata$Date, febdata$Time)
febdata$datetime <- strptime(febdata$datetime, "%d/%m/%Y %H:%M:%S")

# Change data type to numeric
febdata$Global_active_power <- as.numeric(as.character(febdata$Global_active_power))

#----------------------------------------------------
# Plot 1: Histogram of Global Active Power
#----------------------------------------------------
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(febdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()