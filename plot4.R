# Load the data
power_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", 
                         colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time variables to Date/Time class
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$datetime <- as.POSIXct(paste(power_data$Date, power_data$Time), format="%Y-%m-%d %H:%M:%S")

# Subset data for February 1-2, 2007
power_data <- subset(power_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create PNG device
png(filename="plot4.png", width=480, height=480)

# Set up a 2×2 plotting area
par(mfrow=c(2,2), mar=c(4,4,2,1))

# Define day positions for x-axes
axis_positions <- c(
  min(power_data$datetime),  # Thursday (start of Feb 1)
  as.POSIXct("2007-02-02 00:00:00"),  # Friday (start of Feb 2)
  as.POSIXct("2007-02-03 00:00:00")   # Saturday (start of Feb 3)
)

# Define day labels
axis_labels <- c("Thu", "Fri", "Sat")

# Plot 1: Global Active Power vs. Time
plot(power_data$datetime, power_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power",
     xaxt="n")
axis(1, at=axis_positions, labels=axis_labels)

# Plot 2: Voltage vs. Time
plot(power_data$datetime, power_data$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage",
     xaxt="n")
axis(1, at=axis_positions, labels=axis_labels)

# Plot 3: Energy Sub-metering vs. Time
plot(power_data$datetime, power_data$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab="",
     xaxt="n")
lines(power_data$datetime, power_data$Sub_metering_2, col="red")
lines(power_data$datetime, power_data$Sub_metering_3, col="blue")
axis(1, at=axis_positions, labels=axis_labels)
legend("topright", 
       col=c("black", "red", "blue"),
       lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")  # No box around legend

# Plot 4: Global Reactive Power vs. Time
plot(power_data$datetime, power_data$Global_reactive_power, 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power",
     xaxt="n")
axis(1, at=axis_positions, labels=axis_labels)

# Close the PNG device
dev.off()