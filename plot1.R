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

png("plot1.png", width=480, height=480, units="px")
hist(powerData$Global_active_power, col="red",
    main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
