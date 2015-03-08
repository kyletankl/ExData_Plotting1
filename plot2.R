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
        png(filename="plot2.png", width=480, height=480, units="px")
        plot(df$Time, df$Global_active_power, type="l", main="", 
             xlab="", ylab="Global Active Power (kilowatts)")

# disable png device
        dev.off()
