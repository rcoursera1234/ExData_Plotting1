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

# Plotting the figure to the PNG
png(filename="plot2.png", width=480, height=480)
plot(dta$Time, dta$Global_active_power, type="l", ylab="Global Active Power (killwatts)", xlab="")
dev.off()