#Exploratory Data Analysis Week 1 Project
#Plot 2

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

#creates histogram
with(feb07, plot(Global_active_power~datetime, type = "l", ylab = "Global Active Power (kilowatts)"))

#copies plot to .PNG file
dev.copy(png, file = "plot2.png")
dev.off()


