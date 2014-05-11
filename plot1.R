#Exploratory Data Analysis Project 1: plot1.R
#Creates a histogram from power consumption data and saves it as a PNG file.

#Plot 1
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
dataFeb <- read.table(dataSetFileName, skip=firstRowOfSet, nrows=rowCountForSet, col.names = colNames, header=FALSE, sep=";")

#File name and dimensions for the PNG file 
plot1Name <- "plot1.png"
plot1Height <- 480 #original was 504
plot1Width <- 480 #original was 504

#Define the PNG file as the output graphics device. Background is transparent
png(plot1Name, width=plot1Width, height=plot1Height, bg="transparent", units="px")

#Define the plot as one row and one column, to reset incase previous plot had multiple rows and columns
par(mfrow=c(1,1))

#Generate the histogram from the Global Active Power data.
hist(dataFeb[,3], col="red", breaks=12, main="Global Active Power", xlab="Gobal Active Power (kilowatts)", ylab="Frequency", ylim=c(0,1200))

#Turn the PNG device off
dev.off()
