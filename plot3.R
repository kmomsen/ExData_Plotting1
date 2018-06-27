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

# Change data types to numerics
febdata$Sub_metering_1 <- as.numeric(as.character(febdata$Sub_metering_1))
febdata$Sub_metering_2 <- as.numeric(as.character(febdata$Sub_metering_2))
febdata$Sub_metering_3 <- as.numeric(as.character(febdata$Sub_metering_3))

#----------------------------------------------------
#Plot 3: Sub metering (1-3) vs date-time
#----------------------------------------------------
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(febdata$datetime, febdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(febdata$datetime, febdata$Sub_metering_2, type = "l", col = "red")
lines(febdata$datetime, febdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)
dev.off()