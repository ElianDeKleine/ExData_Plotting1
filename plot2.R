#Download de dataset
filename <- "exdata_data_household_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("household_power_consumption")) { 
  unzip(filename) 
}

#read data
mydata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#set the Date
mydata$Date<-as.Date(mydata$Date, format = "%d/%m/%Y")

#subset the data to first 2 days of February
February <- subset(mydata, mydata$Date >= "2007-02-01" & mydata$Date <= "2007-02-02")

#assign missing values
February$Time[February$Time=="?"] <- NA
February$Global_active_power[February$Global_active_power=="?"] <- NA
February$Global_reactive_power[February$Global_reactive_power=="?"] <- NA
February$Voltage[February$Voltage=="?"] <- NA
February$Global_intensity[February$Global_intensity=="?"] <- NA
February$Sub_metering_1[February$Sub_metering_1=="?"] <- NA
February$Sub_metering_2[February$Sub_metering_2=="?"] <- NA
February$Sub_metering_3[February$Sub_metering_3=="?"] <- NA

#Combine Date and Time in DateTime column
February$DateTime<-as.POSIXct(paste(February$Date, February$Time), format="%Y-%m-%d %H:%M:%S")

#Create plot

png("plot2.png", width=480, height=480)

## Plot 2
with(February, {
  plot(Global_active_power~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})

dev.off()