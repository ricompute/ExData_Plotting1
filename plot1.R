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
png(file = "plot1.png", bg = "transparent")  # default height/width (480 px)

# Create plot
hist(dat$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close device
dev.off()
