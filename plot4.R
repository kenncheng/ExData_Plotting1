# ------------------------------------------------------------------------------
# Plot 4 of course project 1 in Exploratory Data Analysis
# Data on Electric power consumption 
# 
# Author: Ken Cheng
# ------------------------------------------------------------------------------
# Data Source - https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Data has been unzipped into the working directory with file name - household_power_consumption.txt
# 
# install package "dplyr" 
#  install.packages("dplyr")
  library(dplyr)

# Read data 
  houseData <- read.table("household_power_consumption.txt", sep=";", header = TRUE,
                        na.strings = "?", colClasses=c("character", "character", rep("numeric", 1, 7)))
# subset data which have dates from 2007-02-01 and 2007-02-02
  data <- subset(houseData, Date=="1/2/2007" | Date=="2/2/2007")

# convert column Date to required format of YYYY-MM-DD
  data <- mutate(data, Date = as.Date(data[,1], format='%d/%m/%Y'))

# create a new column called DateTime using Date and Time
  data <- mutate(data, DateTime=as.POSIXct(paste(Date, Time)))

# Open PNG device
  png(filename = "plot4.png", width = 480, height = 480)

# Specify the layout of the graphs to be 2 columns x 2 rows
  par(mfcol = c(2,2))

# Create plot on 1st column 1st row 
  plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab="")

# Create plot on 1st column 2nd row
  plot(data$DateTime, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(data$DateTime, data$Sub_metering_2, col = "red")
  lines(data$DateTime, data$Sub_metering_3, col = "blue")
  legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
         col = c('black', 'red', 'blue'), lty = 1, cex =0.75)

# Create plot on 2nd column 1st row
  plot(data$DateTime, data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

# Create plot on 2nd column 2nd row
  plot(data$DateTime, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

# close the device
  dev.off()
  