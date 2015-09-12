baseWD <- getwd()

# Download the zip file only if the unzipped file does not exist
if (!file.exists("household_power_consumption.txt")) {
  #downlading the data and unzipping it
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "HouseholdPowerConsumption.zip", quiet=TRUE)
  unzip("HouseholdPowerConsumption.zip")
}

# Read in the unzipped file into a table
table<-read.table("household_power_consumption.txt", header=T,sep=";")
summary(table)

# Set the format for the data
table$Date <- as.Date(table$Date, format="%d/%m/%Y")

# Take a subset of the data in the table, for rows that belong to the two consequtive days
df <- table[(table$Date=="2007-02-01") | (table$Date=="2007-02-02"),]

# change datatype to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))

# change format for date and time fields
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Sub_metering values as numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Plot2
plot2 <- function() {
  plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
  cat("plot2.png has been saved in", getwd())
}
plot2()

