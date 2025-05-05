# Load the data
power_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", 
                         colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time variables to Date/Time class
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Subset data for February 1-2, 2007
power_data <- subset(power_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create PNG device
png(filename="plot1.png", width=480, height=480)

# Create histogram
hist(power_data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

# Close the PNG device
dev.off()