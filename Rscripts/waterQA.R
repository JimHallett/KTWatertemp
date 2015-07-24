library(RODBC)
library(tidyr)
library(lubridate)
library(dplyr)

#####################################################################################
# Kalispel Water Temperature
#####################################################################################

## Read from local SQL

# channel <- odbcConnect("KestralSQL")

CCATemp <- tbl_df(read.csv("CCA1.csv", stringsAsFactors=F))

CCATemp$DateTime <- as.POSIXct(paste(CCATemp$Date, CCATemp$Time), format="%m/%d/%Y %I:%M:%S %p")

plot(CCATemp$DateTime, CCATemp$Temp)

NTemp <- select(CCATemp, Temp, DateTime) %>%
  group_by(round(julian(DateTime))) %>%
  summarize(total.count = n()) %>%
  filter(total.count != 24 & total.count != 48)

#merging different files

DaysGT25 <- group_by(CCATemp, Date) %>%
  filter(Temp > 25.0) %>%
  summarise(count = n())
