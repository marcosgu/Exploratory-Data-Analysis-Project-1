load_data <- function() {
  
  # load only header
  header <- read.table("household_power_consumption.txt", 
                       header = FALSE, 
                       sep = ";", 
                       stringsAsFactors = FALSE, 
                       nrows = 1)
  # load rest of the data (only from selected dates)
  data <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", 
                     colClasses=c("character", "character", 
                                  rep("numeric",7)), 
                     na.strings = "?",
                     nrows = 2880, 
                     skip = 66636)
  # set column names with info from header
  colnames(data) <- unlist(header)
  # convert date and time to Date/Time class
  data$Time <- strptime(paste(data$Date, data$Time), 
                        "%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  return(data)
}


plot3 <- function() {
  
  data <- load_data()
 
  png("plot3.png", width = 480, height = 480)
  
  with(data, plot(Time, Sub_metering_1,
                  type="l",
                  xlab="",
                  ylab="Energy sub metering"))
  with(data, lines(Time, Sub_metering_2,
                   col = "red"))
  with(data, lines(Time, Sub_metering_3,
                   col = "blue"))
  legend("topright", legend=c("Sub_metering_1", 
                              "Sub_metering_2",
                              "Sub_metering_3"),
         col = c("black","red", "blue"), 
         lty = c(1,1))
  tmp <- dev.off()
}
