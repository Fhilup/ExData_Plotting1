#Exploratory Data Analysis Week 1 Project
#Plot 3

#introduce data variable to save time if file is already downlaoded
setwd("C:/Users/u129129/Desktop/R/4. Exploratory Data Analysis/week1")
data <- "dataset.zip"

#checks if file is downloaded from url, if not, downloads to destination and records date
if(!file.exists("data")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "C:/Users/u129129/Desktop/R/4. Exploratory Data Analysis/week1/dataset.zip")
    datedownloaded <- date()
}

#unzips files if not already unzipped
folder <- "week1"
if(!file.exists(folder)){
    unzip(data)
}

#reads in text file
#file <- read.delim("household_power_consumption.txt", sep = ";") reads in as factors, not best choice
file <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#subsets only the selected dates
feb07 <- subset(file, Date == "1/2/2007" | Date == "2/2/2007")

#converts Date to Date class
feb07$Date <- as.Date(feb07$Date, format = "%d/%m/%Y")

#converts date & time & converts datetime to POSIXct
feb07$datetime <- as.POSIXct(strptime(paste(feb07$Date, feb07$Time), "%Y-%m-%d %H:%M:%S"))

#sets graphical parameters, 2 rows, 2 columns, rows populate first
par(mfrow = c(2,2))

#sets graphic parameters, margins
par(mar = c(4,2,4,2))

#graph 1, top left (plot2.R)
with(feb07, plot(Global_active_power~datetime, type = "l", ylab = "Global Active Power (kilowatts)"))

#graph 2, top right (new plot)
with(feb07, plot(Voltage~datetime, type = "l", ylab = "Voltage"))

#graph 3, bottom left (plot3.R)
with(feb07, plot(Sub_metering_1~datetime, type = "l", ylab = "Energy Sub Metering"))
with(feb07, lines(Sub_metering_2~datetime, col = "red"))
with(feb07, lines(Sub_metering_3~datetime, col = "blue"))
#assigns legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")

#graph 4, bottom right (new plot)
with(feb07, plot(Global_reactive_power~datetime, type = "l"))

#copies plot to .PNG file
dev.copy(png, file = "plot4.png")
dev.off()