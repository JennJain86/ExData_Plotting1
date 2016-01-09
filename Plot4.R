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
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE, na.strings= "?", strip.white =TRUE)

# Subset data for dates specified in the assignment's instructions
filtered_power_consumption <- subset(power_consumption, Date== "1/2/2007" | Date== "2/2/2007")

# Create Date/Time and Weekday variable 
filtered_power_consumption$Date <- as.Date(filtered_power_consumption$Date, format="%d/%m/%Y")

filtered_power_consumption$Date_Time <- as.POSIXct(paste(filtered_power_consumption$Date, filtered_power_consumption$Time), format = "%Y-%m-%d %H:%M:%S")

timeline <-c(min(filtered_power_consumption$Date_Time), max(filtered_power_consumption$Date_Time))

#filtered_power_consumption$Date_Time =paste(filtered_power_consumption$Date, filtered_power_consumption$Time)
#filtered_power_consumption$Date_Time <-strptime(filtered_power_consumption$Date_Time,"%d/%m/%Y %H:%M:%S")
#attach(filtered_power_consumption)

filtered_power_consumption$Weekday <- as.POSIXlt(filtered_power_consumption$Date_Time)$wday
filtered_power_consumption$Weekday <-c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")[as.POSIXlt(filtered_power_consumption$Date_Time)$wday +1]

###############################Generate Plot 4##################################



png(file= "plot4.png", width =480, height =480)
attach(filtered_power_consumption)
par(mfrow=c(2,2))

# Top Left

plot(filtered_power_consumption$Date_Time, as.numeric(as.character(filtered_power_consumption$Global_active_power)), type="l", xlab="", ylab="Global Active Power", xlim = timeline)

# Top Right

plot(filtered_power_consumption$Date_Time, as.numeric(as.character(filtered_power_consumption$Voltage)), type="l", xlab="datetime", ylab="Voltage", xlim = timeline)

# Bottom Left
plot(filtered_power_consumption$Date_Time, as.numeric(as.character(filtered_power_consumption$Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", xlim = timeline)
lines( filtered_power_consumption$Date_Time,filtered_power_consumption$Sub_metering_2, col="red")
lines( filtered_power_consumption$Date_Time,filtered_power_consumption$Sub_metering_3, col="blue")
legend("topright", lty = c(1,1,1), 
        col = c("black", "red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Bottom Right

plot(filtered_power_consumption$Date_Time, as.numeric(as.character(filtered_power_consumption$Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power", xlim = timeline)

dev.off()
