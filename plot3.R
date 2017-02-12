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
png("plot2.png", width=480, height=480, units="px")
par(mfrow = c(1,1))
plot(electric$DateTime, electric$Global_active_power, type="l", xlab="",
     ylab = "Global Active Power (kilowatts)", main = "")
dev.off()