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
        png(filename="plot1.png", width=480, height=480, units="px")
        hist(df$Global_active_power, main="Global Active Power", 
             xlab="Global Active Power (kilowatts)", ylab="Frequency",
             col="red")

# disable png device
        dev.off()
