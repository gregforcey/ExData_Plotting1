# Remove all R objects from memory; important for creating a clean workspace
rm(list = ls()) 

#Set the working directory
setwd("~/OneDrive/Development/COURSEWORK/coursera-exploratory-data-analysis/week1")

# Read in necessary libraries
library(readr)
library(dplyr)

# Read in the data - keep time a character for simplicity in combining below
electric <- filter(read_delim(file = "data/household_power_consumption.txt",
                              delim = ";",na="?",
                              col_types = cols(col_date(format="%d/%m/%Y"),
                                               col_character(),
                                               col_double(),
                                               col_double(),
                                               col_double(),
                                               col_double(),
                                               col_double(),
                                               col_double(),
                                               col_double())),
                   Date == "2007-02-01" | 
                   Date == "2007-02-02")

# Combine date and time into one field
electric$DateTime <- strptime(paste(electric$Date,electric$Time),
                              format = "%Y-%m-%d %H:%M:%S")

# Create the requested PNG file
png("plot4.png", width=480, height=480, units="px")
par(mfcol = c(2,2)) # 2 X 2 plot matrix

# Plot 1 - upper left
plot(electric$DateTime, electric$Global_active_power, type="l", xlab="",
     ylab = "Global Active Power (kilowatts)", main = "")

# Plot 2 - lower left
plot(electric$DateTime, electric$Sub_metering_1, type="l", xlab="",
     ylab = "Energy sub metering", main = "", col="black")
lines(electric$DateTime, electric$Sub_metering_2, type="l", col="red")
lines(electric$DateTime, electric$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col=c("black","red","blue"), lty = "solid")

# Plot 3 - upper right

plot(electric$DateTime, electric$Voltage, type="l", xlab="datetime",
     ylab = "Voltage", main = "")

# Plot 4 - lower right

plot(electric$DateTime, electric$Global_reactive_power, type="h", xlab="datetime",
     ylab = "Global_reactive_power", main = "")

dev.off()