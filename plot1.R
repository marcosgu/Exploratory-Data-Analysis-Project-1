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
  
  return(data)
}


plot1 <- function() {

  data <- load_data()
  
  png("plot1.png", width = 480, height = 480)
  
  with(data, hist(Global_active_power,
      main = "Global Active Power",
      col = "red", 
      xlab = "Global Active Power (kilowatts)"))
  tmp <- dev.off()
}
