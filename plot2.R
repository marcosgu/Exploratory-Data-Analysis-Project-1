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


plot2 <- function() {

  data <- load_data()

  png("plot2.png", width = 480, height = 480)
  
  with(data, plot(Time, Global_active_power,
       type="l",
       xlab="",
       ylab="Global Active Power (kilowatts)"))
  tmp <- dev.off()
}
