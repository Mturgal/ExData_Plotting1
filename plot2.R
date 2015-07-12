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


##Second Graph (2)
png("plot2.png",width =480, height=480)
with(GraphData,plot(Time,Global_active_power,xlab="", ylab="Global Active Power (kilowatts)", type="n"))
with(GraphData,lines(Time,Global_active_power))
dev.off()
