library(tidyverse)

wd <- getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(wd,"/2FNEI_data.zip"))

unzip("2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)
str(NEI)

## Question 1 : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# data_set
nei_pm25_total <- NEI %>% 
  group_by(year) %>% 
  summarise(total_pm25 = sum(Emissions))

# base plot
dev.cur()

png(file = "plot1.PNG",width=480, height=480)
plot(nei_pm25_total$year, nei_pm25_total$total_pm25, 
     xlab = "Year", ylab = 'Total_pm2.5', main = "total pm2.5 emission in United States")

dev.off()

# Answer : Yes, it was decreaed