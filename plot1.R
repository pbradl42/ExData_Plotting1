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

plot1 <- function() { 
  library(lubridate)
  
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

  startDate <- ymd_hms("2007-02-01 00:00:00")
  endDate <- ymd_hms("2007-02-02 23:59:59")
  myData[myData$newDate >= startDate & myData$newDate <= endDate, ] -> subsetData
  #message(nrow(subsetData))
  #head(subsetData)
  ## Plot 1
  png("plot1.png")
  hist(subsetData$Global_active_power, col = "red", main = "Global active power", xlab = "Global active power (kilowatts)")
  dev.off()
    
    # rm(myData)
    par(oldpar)
}