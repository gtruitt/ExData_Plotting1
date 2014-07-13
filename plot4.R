setClass("xDate")
setAs("character","xDate",
      function(from) as.Date(from, format="%d/%m/%Y"))

xColClasses = c(
    "xDate", "character", "numeric", "numeric", "numeric",
    "numeric", "numeric", "numeric", "numeric")

rawPowerData <- read.table("household_power_consumption.txt",
                           header=TRUE, sep=";", na.strings=c("?"), colClasses=xColClasses)

datesForAnalysis <- as.Date(c("2007-02-01", "2007-02-02"))
rowsForAnalysis <- (rawPowerData$Date %in% datesForAnalysis)

powerData <- rawPowerData[rowsForAnalysis,]
rm(rawPowerData)

dateTimeCol <- strptime(
    paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")
powerData <- cbind(powerData, DateTime=dateTimeCol)

png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
plot(powerData$DateTime, powerData$Global_active_power,
    type="l", xlab="", ylab="Global Active Power")
plot(powerData$DateTime, powerData$Voltage,
    type="l", xlab="datetime", ylab="Voltage")
plot(powerData$DateTime, powerData$Sub_metering_1,
    type="l", xlab="", ylab="Energy sub metering")
lines(powerData$DateTime, powerData$Sub_metering_2, col="red")
lines(powerData$DateTime, powerData$Sub_metering_3, col="blue")
legend("topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"), lty=c(1, 1, 1), bty="n")
plot(powerData$DateTime, powerData$Global_reactive_power,
    type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
