# ---- Download file ----------------------------------------------------------
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

# ---- Unzip file --------------------------------------------------------------
unzip("household_power_consumption.zip")

# ---- Read file into R --------------------------------------------------------
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   na.strings = "?", sep = ";")

# ---- Subset the dates of interest --------------------------------------------
dat <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]
rm(data)

# ---- Convert dates and times to appropriate classes --------------------------
dat$Date <- as.Date(data$Date, format = "%d/%m/%Y")
