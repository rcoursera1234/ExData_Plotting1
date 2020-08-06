library(data.table)
doc <- "./data/household_power_consumption.txt"
# Load the document on memory
DT <- fread(doc, na.strings="?", sep=";", header=TRUE, nrows=2075529, stringsAsFactors=FALSE)
# Subset the data to the specify Dates and remove the complete data
dta <- DT[ Date == "1/2/2007" | Date == "2/2/2007" ]
rm(DT)

# change the values of dta$Date and dta$Time to their respected POSIXct
dta$Time <- dta[, strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")]
dta$Date <- dta[, as.Date(Date, format="%d/%m/%Y")]

# Configure par()
par(mfcol=c(2,2), mar=c(4,4,1,1))
# Make first plot
plot(dta$Time, dta$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# Make second plot
plot(dta$Time, dta$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(dta$Time, dta$Sub_metering_1, col="black")
lines(dta$Time, dta$Sub_metering_2, col="red")
lines(dta$Time, dta$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.60)
# Make third plot
plot(dta$Time, dta$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Make four plot
plot(dta$Time, dta$Global_reactive_power , type="l", xlab="datetime", ylab="Global_reactive_power")