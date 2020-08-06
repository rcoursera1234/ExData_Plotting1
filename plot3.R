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

# Plotting to PNG
png(filename="plot3.png", width=480, height=480)
with(dta, {
  plot(Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(Time, Sub_metering_1, col="black")
  lines(Time, Sub_metering_2, col="red")
  lines(Time, Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
}) # For some reason the col=c("black", "red", "blue") is not working :(
dev.off()