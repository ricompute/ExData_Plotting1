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
png(file = "plot3.png", bg = "transparent")  # default height/width (480 px)

# Create plot
with(dat, plot(x = Time, y = Sub_metering_1, type = "n", 
               xlab = "", ylab = "Energy sub metering"))  # empty plot
with(dat, lines(x = Time, y = Sub_metering_1, col = "black"))
with(dat, lines(x = Time, y = Sub_metering_2, col = "red"))
with(dat, lines(x = Time, y = Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1, lty = 1, col = c("black", "red", "blue"))

# Close device
dev.off()
