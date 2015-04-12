# Loading packages and libraries
install.packages("data.table")
library(data.table)

# setting the path
path <- getwd()
path

# getting the data - Download the file and putting it in the Data folder
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "exdata-data-household_power_consumption.zip"
if (!file.exists(path)) {dir.create(path)}
download.file(url, file.path(path, f))

# unzipping the file
executable <- file.path("C:", "Program Files (x86)", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, f), "\""))
system(cmd) # 7-zip is required to run on machine

# Read the subject files.
datacomplete <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", nrows=2075259)

# Converting dates
datacomplete$Date <- as.Date(datacomplete$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(datasub$Date), datasub$Time)
datasub$Datetime <- as.POSIXct(datetime)

# Subsetting the data
datasub <- subset(datacomplete, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(datacomplete)

# Plot 4
par(mar = c(2, 4, 1, 1), mfrow=c(2,2))

plot(datasub$Global_active_power~datasub$Datetime, type="l", ylab="Global Active Power", xlab="")
plot(datasub$Voltage~datasub$Datetime, type="l", ylab="Voltage", xlab="datetime")
with(datasub, {plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~Datetime, col = "red")
     lines(Sub_metering_3~Datetime, col = "blue")})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty=0, text.width = 95000)
plot(datasub$Global_reactive_power~datasub$Datetime, type="l", ylab="Global_reactive_power", xlab="datetime")

# Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

