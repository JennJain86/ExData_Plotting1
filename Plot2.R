#Jennifer Jain
#Exploritory Data Analysis- Project 1
#January 2016

###############################Loading Data#####################################

# Set working directory
setwd("/Users/JAIN/Desktop/Exploratory_Data_Analysis")


# Download Electric Power Consumption file 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")

# Unzip and read .txt file
unzip("household_power_consumption.zip","household_power_consumption.txt")
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

# Subset data for dates specified in the assignment's instructions
filtered_power_consumption <- subset(power_consumption, Date== "1/2/2007" | Date== "2/2/2007")

# Create a Date/Time variable 
filtered_power_consumption$Date <- as.Date(filtered_power_consumption$Date, format="%m/%d/%Y")

filtered_power_consumption$Date_Time <- as.POSIXct(paste(filtered_power_consumption$Date, filtered_power_consumption$Time), format = "%Y-%m-%d %H:%M:%S")

###############################Generate Plot 2##################################

png(file= "plot2.png", width =480, height =480)
plot(filtered_power_consumption$Date_Time, as.numeric(as.character(filtered_power_consumption$Global_active_power)), type="l", xlab="", ylab="Global Active Power", xlim = timeline)
dev.off()