# Load data into R and format --------------------------------------------------

# Unzip data file
unzip("household_power_consumption.zip")

# Read file into R
dat <- read.table("household_power_consumption.txt", header = TRUE, 
                  na.strings = "?", sep = ";")

# Subset the dates of interest
dat <- dat[(dat$Date == "1/2/2007") | (dat$Date == "2/2/2007"), ]

# Convert dates and times to appropriate classes
dat$Time <- strptime(paste(dat$Date, dat$Time, sep = " "), 
                     format = "%d/%m/%Y %H:%M:%S")

# Create plot file -------------------------------------------------------------

# Open png device
png(file = "plot4.png", bg = "transparent")  # default height/width (480 px)

# Create plot
par(mfrow = c(2, 2))  # set up 2 x 2 grid of plots

with(dat, plot(x = Time, y = Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power"))

with(dat, plot(x = Time, y = Voltage, type = "l",
               xlab = "datetime", ylab = "Voltage"))

with(dat, plot(x = Time, y = Sub_metering_1, type = "n", 
               xlab = "", ylab = "Energy sub metering"))  # empty plot
with(dat, lines(x = Time, y = Sub_metering_1, col = "black"))
with(dat, lines(x = Time, y = Sub_metering_2, col = "red"))
with(dat, lines(x = Time, y = Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.95, bty = "n", lwd = 1, lty = 1, col = c("black", "red", "blue"))

with(dat, plot(x = Time, y = Global_reactive_power, type = "l",
               xlab = "datetime", ylab = "Global_reactive_power"))

# Close device
dev.off()
