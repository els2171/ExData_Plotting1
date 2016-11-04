## Store URL of data from UCI ML Repo
fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

## Download and unzip data file to current directory
download.file(fileURL, destfile = './power.zip')
unzip('./power.zip')

## Read in a portion of the file to reduce memory requirements and update column names
power <- read.table('household_power_consumption.txt', sep= ';', na.strings = '?', skip = 66240, nrows = 8000)
names(power) <- c('Date', 'Time', 'Global Active Power', 'Global Reactive Power', 'Voltage', 'Global Intensity', 'Sub Metering 1', 'Sub Metering 2', 'Sub Metering 3')

## Restrict to 01/02/2007 and 02/02/207
power_tbl <- subset(power, power$Date == '1/2/2007' | power$Date== '2/2/2007')

## Convert Date to easier format
power_tbl$Date <- as.Date(power_tbl$Date, '%d/%m/%Y')

## Build histogram of Global Active Power as PNG file plot1.png
png(filename = 'plot1.png')
hist(power_tbl$`Global Active Power`, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', col = 'red')
dev.off()

