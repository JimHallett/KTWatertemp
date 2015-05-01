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


#CCATemp$Date <- mdy(CCATemp$Date)


CCATemp$DateTime <- as.POSIXct(paste(CCATemp$Date, CCATemp$Time), format="%m/%d/%Y %I:%M:%S %p")

plot(CCATemp$DateTime, CCATemp$Temp)

