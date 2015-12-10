# Download file ----------------------------------------------------------------
library(downloader)
file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_name <- "household_power_consumption.zip"
download(file_URL, file_name)

# Document time of download in a text file
file.create("date_downloaded_zip.txt")
file_connection <- file("date_downloaded_zip.txt")
writeLines(c(file_name,
             "was downloaded from",
              file_URL,
              "at",
              as.character(Sys.time())), 
           file_connection)
close(file_connection)

# Unzip file -------------------------------------------------------------------
unzip("household_power_consumption.zip")

# Read file into R -------------------------------------------------------------
dat <- read.table("household_power_consumption.txt", header = TRUE, 
                   na.strings = "?", sep = ";")

# Subset the dates of interest -------------------------------------------------
dat <- dat[(dat$Date == "1/2/2007") | (dat$Date == "2/2/2007"), ]

# Convert dates and times to appropriate classes -------------------------------
dat$Time <- strptime(paste(dat$Date, dat$Time, sep = " "), 
                     format = "%d/%m/%Y %H:%M:%S")
