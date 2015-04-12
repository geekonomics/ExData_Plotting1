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

# Subsetting the data
datasub <- subset(datacomplete, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(datacomplete)

# Plot 1
par(mar = c(4, 4, 2, 2))
hist(datasub$Global_active_power, main = "Global Active Power", freq = 200, col = "Red", xlab = "Global Active Power (kilowatts)", density = )

# Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()