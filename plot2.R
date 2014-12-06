# ------------------------------------------------------------------------------
# Plot 2 of course project 1 in Exploratory Data Analysis
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

# specify layout of graph/plot to be 1 row x 1 col
  par(mfrow = c(1,1))

# Open PNG device
  png(filename = "plot2.png", width = 480, height = 480)

# Create the plot
  plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab="")

# close the device
  dev.off()
  