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

hist(dfData$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, ylim = c(0, 1200), xlim = c(0, 6), xaxp = c(0, 6, 3))
