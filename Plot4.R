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

par(mfrow = c(2, 2))

# plot 1 (NW)
plot(dfData$Datetime, dfData$Global_active_power, type = "l", ylab = "Global Active Power", 
     xlab = "")

# plot 2 (NE)
plot(dfData$Datetime, dfData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3 (SW)
plot(dfData$Datetime, dfData$Sub_metering_1, type = "l", ylab = "Energy sub metering", 
     xlab = "", col = "black")
points(dfData$Datetime, dfData$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", 
       col = "red")
points(dfData$Datetime, dfData$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", 
       col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
                                                                        "Sub_metering_2", "Sub_metering_3"), bty = "n", )

# plot 4 (SE)
plot(dfData$Datetime, dfData$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", ylim = c(0, 0.5))