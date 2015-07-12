##reading the data with only including the target date
data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?",header=FALSE,skip=60000, 
                   nrows=10000)


##to get the header from the data rean the beginning of the data to another object
header <- read.table("household_power_consumption.txt", sep=";", na.strings = "?",header=TRUE, nrows=4)


## Make the colnames of header the column names of data 
colnames(data)<- colnames(header)


## convert the date from character to date format so that subsetting acc to Date is possible
data$Date <-as.Date(data$Date, "%d/%m/%Y")


## Converting the time to POSIXlt class by first combining original Date and Time and then applying strptime
data$StrTime <- paste(data$Date,data$Time)
data$Time <- strptime(data$StrTime, "%Y-%m-%d %H:%M:%S")
data$StrTime <- NULL


##Subsetting the data with the target dates
GraphData <- subset(data,data$Date=="2007-02-01"|data$Date=="2007-02-02")


#Fourth Graph (4)
png("plot4.png",width =480, height=480)
par(mfrow=c(2,2))
with(GraphData,{
  plot(Time,Global_active_power, ylab="Global Active Power",xlab="", type="n")
  lines(Time,Global_active_power)
  plot(Time,Voltage, ylab="Voltage",xlab ="datetime", type="n")
  lines(Time,Voltage)
  plot(Time,Sub_metering_1, ylab= "Energy sub metering",xlab="",type="n")
  lines(Time,Sub_metering_1)
  lines(Time,Sub_metering_2,col="red")
  lines(Time,Sub_metering_3,col="blue")
  legend("topright" ,bty="n",lty=1, col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Time,Global_reactive_power ,xlab ="datetime", type="n")
  lines(Time,Global_reactive_power)
})

dev.off() 

