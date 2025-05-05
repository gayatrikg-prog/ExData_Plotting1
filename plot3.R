# Load the data
power_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", 
                         colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time variables to Date/Time class
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$datetime <- as.POSIXct(paste(power_data$Date, power_data$Time), format="%Y-%m-%d %H:%M:%S")

# Subset data for February 1-2, 2007
power_data <- subset(power_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create PNG device
png(filename="plot3.png", width=480, height=480)

# Create plot with first sub-metering but suppress x-axis
plot(power_data$datetime, power_data$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab="",
     xaxt="n")  # Suppress default x-axis

# Add lines for other sub-metering measurements
lines(power_data$datetime, power_data$Sub_metering_2, col="red")
lines(power_data$datetime, power_data$Sub_metering_3, col="blue")

# Create custom x-axis with day names
# Calculate positions for Thursday, Friday, and Saturday
axis_positions <- c(
  min(power_data$datetime),  # Thursday (start of Feb 1)
  as.POSIXct("2007-02-02 00:00:00"),  # Friday (start of Feb 2)
  as.POSIXct("2007-02-03 00:00:00")   # Saturday (start of Feb 3)
)

# Create day labels
axis_labels <- c("Thu", "Fri", "Sat")

# Add the custom axis
axis(1, at=axis_positions, labels=axis_labels)

# Add legend
legend("topright", 
       col=c("black", "red", "blue"),
       lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the PNG device
dev.off()