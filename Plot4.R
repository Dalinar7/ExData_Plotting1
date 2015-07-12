data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

rightDays <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
GAP <- as.numeric(rightDays$Global_active_power)
VOLT <- as.numeric(rightDays$Voltage)
GRP <- as.numeric(rightDays$Global_reactive_power)
times <- as.POSIXct(strptime(rightDays$Time, format = "%H:%M"))-as.POSIXct(Sys.Date())
dates <- as.POSIXct(rightDays$Date, format = "%d/%m/%Y")


datesAndTimes <- dates + times - 60*60*4
#The above is a work around for the axes to shift time back (instead 
#of formally converting the time to PST) 

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

plot(datesAndTimes,GAP, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)")

plot(datesAndTimes, VOLT, type = 'l', xlab = "datetime", ylab = "Voltage")

plot(datesAndTimes, rightDays$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy sub metering")
lines(datesAndTimes, rightDays$Sub_metering_2, col = "red")
lines(datesAndTimes, rightDays$Sub_metering_3, col = "blue")

plot(datesAndTimes, GRP, type = 'l', xlab = "datetime", ylab = "Global_reactive_power")

dev.off()