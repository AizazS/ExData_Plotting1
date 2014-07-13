library(sqldf)
library(tcltk)
setwd("C:\\Users\\Aizaz\\Documents\\data")
if (!file.exists("./data/household_power_consumption.txt")) {
  url1<- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(url1,"./household_power_consumption.zip", method="curl")
  unzip("./household_power_consumption.zip")
}

dfData <- read.table(pipe('findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt'),header=F, sep=';')
colnames(dfData) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))


dfData$Datetime <- strptime(paste(dfData$Date, dfData$Time), "%d/%m/%Y %H:%M:%S")

plot(dfData$Datetime, dfData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(dfData$Datetime, dfData$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
points(dfData$Datetime, dfData$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
                                                                        "Sub_metering_2", "Sub_metering_3"))