library(tidyverse)

wd <- getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(wd,"/2FNEI_data.zip"))

unzip("2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)
str(NEI)

## Question 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 

# data_set
nei_baltimore <- NEI %>% 
  filter(fips =="24510") %>% 
  group_by(year) %>% 
  summarise(total_pm25_balt = sum(Emissions))

# base plot
dev.cur()

png(file = "plot2.PNG",width=480, height=480)
plot(nei_baltimore$year, nei_baltimore$total_pm25_balt, 
     xlab = "Year", ylab = "pm2.5", main = "total pm2.5 emission in Baltimore City, Maryland")

dev.off()

# Answer : Though it was increased in 2006, it was decreaed from 1999 to 2008.