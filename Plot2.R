data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

rightDays <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
GAP <- as.numeric(rightDays$Global_active_power)

times <- as.POSIXct(strptime(rightDays$Time, format = "%H:%M"))-as.POSIXct(Sys.Date())
dates <- as.POSIXct(rightDays$Date, format = "%d/%m/%Y")

datesAndTimes <- dates + times - 60*60*4
#The above is a work around for the axes to shift time back (instead 
#of formally converting the time to PST) 
png("plot2.png", width=480, height=480)
plot(datesAndTimes,GAP, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()