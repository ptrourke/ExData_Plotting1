#Exploratory Data Analysis Project 1: plot4.R
#Creates a four-part plot power consumption data and saves it as a PNG file.

#Plot 4
# Set the working directory to the local GitHub repositor
setwd("~/ExData_Plotting1")

#Download the data file, unzip it. The result will be a file called *household_power_consumption.txt*
dataSetZipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataSetFileName <- "./household_power_consumption.txt"
zipFileName <- "./power.zip"
download.file(dataSetZipFileUrl, zipFileName, method="curl")
unzip(zipFileName,overwrite=TRUE)

#Parameters for read.table. The column names come from the README.md file for the assignment.
colNames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Worked out the correct first row and last row of the data for February 1 and 2 using R.
firstRowOfSet <- 66637
rowCountForSet <- 2880

#Read the data in as a data table. Skip to the first row, read 2880 rows (one for each minute of a 2-day period), assign the column names, ignore the existing header
dataFebWeekdays <- read.table(dataSetFileName, skip=firstRowOfSet, nrows=rowCountForSet, col.names = colNames, header=FALSE, sep=";")

#File name and dimensions for the PNG file 
plot4Name <- "plot4.png"
plot4Height <- 480 #original was 504
plot4Width <- 480 #original was 504

#Define the PNG file as the output graphics device. Background is transparent
png(plot4Name, width=plot4Width, height=plot4Height, bg="transparent", units="px")


#Create a DateTime row that formats the Date and Time together as a POSIXct; 
#this will make it easier to plot by time (rather than using the strptime() and as.Date() functions)
dataFebWeekdays$DateTime <- as.POSIXct(paste(dataFebWeekdays$Date,dataFebWeekdays$Time), format="%d/%m/%Y %H:%M:%S")

#Define the plot as two rows and two columns, allowing four plots in one image
par(mfrow=c(2,2))

#Generate a line graph from the Global Active Power data (by frequency). Don't inlcude "kilowatts" in the label this time.
plot(dataFebWeekdays$DateTime,dataFebWeekdays$Global_active_power, type="l" ,ylab="Global Active Power", xlab="")

#Generate a line graph from the Voltage data (by date).
plot(dataFebWeekdays$DateTime,dataFebWeekdays$Voltage, type="l" ,ylab="Voltage", xlab="datetime")

#Generate a line plot from the Sub Metering 1 data (by date).
plot(dataFebWeekdays$DateTime,dataFebWeekdays$Sub_metering_1, type="l" ,ylab="Energy sub metering", xlab="")
#Add another line for the Sub Metering 2 data.
lines(dataFebWeekdays$DateTime,dataFebWeekdays$Sub_metering_2, type="l", col="red")
#Add another line for the Sub Metering 3 data.
lines(dataFebWeekdays$DateTime,dataFebWeekdays$Sub_metering_3, type="l", col="blue")
#Add a legend with no box around it, using a line in the key, and with the three column names in the top right corner of graph
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Generate a line graph from the Global Reactive Power data (by date).
plot(dataFebWeekdays$DateTime,dataFebWeekdays$Global_reactive_power, type="l" ,ylab="Global_reactive_power", xlab="datetime")

#Turn the PNG device off
dev.off()