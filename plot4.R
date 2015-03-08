# load data
        # assumes data is in same parent folder as R script
        # uses sqldf package to read only required lines
        file <- "./exdata-data-household_power_consumption/household_power_consumption.txt"
        df <- read.csv.sql(file, 
                           sql="select * from file where Date='1/2/2007' OR Date='2/2/2007'",
                           header=T, sep=";", connection=NULL)  # null option terminates connection upon exit
        
# clean missing values "?"
        df[df=="?"] <- NA     # no missing value found actually
        
# convert date, time values
        x <- paste(df$Date, df$Time)
        df$Time <- strptime(x,"%d/%m/%Y %H:%M:%S")
        df$Date <- as.Date(df$Date,"%d/%m/%Y")

# plot to file graphics device
        png(filename="plot4.png", width=480, height=480, units="px")
        
        # set global plot param
        par(mfcol=c(2,2))
        
        # plot 1
        plot(df$Time, df$Global_active_power, type="l", main="", 
             xlab="", ylab="Global Active Power")
        
        # plot 2
        plot(range(df$Time),
             range(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3),
             type="n", main="", xlab="", ylab="Energy sub metering")
        lines(df$Time, df$Sub_metering_1, col="black")
        lines(df$Time, df$Sub_metering_2, col="red")
        lines(df$Time, df$Sub_metering_3, col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col=c("black","red","blue"), lty=1, bty="n", cex=0.7)
        
        # plot 3
        plot(df$Time, df$Voltage, type="l", main="",
             xlab="datetime", ylab="Voltage")
        
        # plot 4
        plot(df$Time, df$Global_reactive_power, type="l", main="",
             xlab="datetime", ylab="Global_reactive_power")

# disable png device
        dev.off()
