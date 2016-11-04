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

## Convert Date and Time to easier format
power_tbl$Date <- as.Date(power_tbl$Date, '%d/%m/%Y')
power_tbl$datetime <- strptime(paste(power_tbl$Date, power_tbl$Time), '%Y-%m-%d %H:%M:%S')

## Set up multiple plots- 2x2
png(filename = 'plot4.png')
par(mfcol = c(2,2))

## Add (1,1) Plot- Global Active Power
plot(power_tbl$datetime, power_tbl$`Global Active Power`, type = 'l', ylab = 'Global Active Power', xlab = '')

## Add (2,1) Plot- Energy Sub Metering
with(power_tbl, plot(power_tbl$datetime, power_tbl$`Sub Metering 1`, type = 'n', xlab = '', ylab = 'Energy sub metering'))
with(power_tbl, lines(datetime, `Sub Metering 1`, type = 'l'))
with(power_tbl, lines(datetime, `Sub Metering 2`, type = 'l', col = 'red'))
with(power_tbl, lines(datetime, `Sub Metering 3`, type = 'l', col = 'blue'))
legend("topright", lwd = 1, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), bty = 'n')

## Add (1,2) Plot- Voltage
plot(power_tbl$datetime, power_tbl$Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')

## Add (2,2) Plot- Global Reactive Power
plot(power_tbl$datetime, power_tbl$`Global Reactive Power`, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')

dev.off()