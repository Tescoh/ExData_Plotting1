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
  
    with(h_power, plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" ))
dev.copy(png, "plot2.png")
dev.off()
        