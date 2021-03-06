estimateSize <- function() {
  2075259 * 9 -> totalCells
  totalCells * 8 -> totalBytes
  totalBytes / 1024
}

getData <- function() {
  # Read in the Table
  read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
  #return myData
}

plot4 <- function() { 
  oldpar <- par()
  mfrow=c(1,1)
  # if the table isn't already in memory, read it in
  ### This isn't working. 'exists(myData)' throws and error when it doesn't exist. Which doesn't make any sense
  myData <- data.frame()
  if(nrow(myData) == 0) {
    myData <- getData()
  }
  # convert existing Date and Time columns into POSIXct objects
  # Store in new column, so as to not mess with the original dataset
  dmy_hms(paste(myData$Date, myData$Time, sep = " ")) -> myData$newDate
  # Change newDate column class

  
  #  apply(myData[, 3-9], 2, as.numeric)
  startDate <- ymd_hms("2007-02-01 00:00:00")
  endDate <- ymd_hms("2007-02-02 23:59:59")
  myData[myData$newDate >= startDate & myData$newDate <= endDate, ] -> subsetData
  #message(nrow(subsetData))
  #head(subsetData)
  
##  create 4 plots in one space
  ## Plot 4
  png("plot4.png")
  
    par(mfrow = c(2,2), mar = c(4,4,4,1), oma = c(0,0,0,0))
    plot(subsetData$newDate, subsetData$Global_active_power, type = "l", ylab = "Global active power", xlab = "")
   ## title(main = "Global active power")
    
    plot(subsetData$newDate, subsetData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    # ylim = c(0, maxY)
    plot(subsetData$newDate, subsetData$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    with(subsetData, lines(newDate, Sub_metering_1, col = "black"))
    with(subsetData, lines(newDate, Sub_metering_2, col = "red"))
    with(subsetData, lines(newDate, Sub_metering_3, col = "blue"))
    legend("topright", names(subsetData)[7:9], lty=c(1,1,1), lwd=c(1,1,1),col=c("black","red", "blue"), bty = "n")
    
    ##title(main = "Sub metering 1-3")               

    
    
    plot(subsetData$newDate, subsetData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    dev.off()
    
    # rm(myData)
    par(oldpar)
}