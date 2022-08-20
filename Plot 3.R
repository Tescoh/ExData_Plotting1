getwd()
h_power <- read.table("household_power_consumption.txt",
                      sep = ";", header = T, na.strings = "?")
library(tidyverse)   
library(lubridate)
h_power <- as_tibble(h_power)    
h_power <- mutate(h_power, Date = dmy(Date), Time = hms::as_hms(Time),
                  Datetime = make_datetime(year(Date), 
                                           month(Date), day(Date), hour(Time), minute(Time), second(Time)))
h_power <- filter(h_power, Date == ymd(20070201) | Date == ymd(20070202))

with(h_power, {plot(Datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
                lines(Datetime, Sub_metering_2, col = "red")
                lines(Datetime, Sub_metering_3, col = "blue")})
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),bty = "n", lwd = c(2,2,2))   
dev.copy(png, "plot3.png")
dev.off()  
