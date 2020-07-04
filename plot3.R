library(tidyverse)

wd <- getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(wd,"/2FNEI_data.zip"))

unzip("2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)
str(NEI)

## Question 3 : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##              which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##              Which have seen increases in emissions from 1999–2008?

# data_set & plot

nei_baltimore_type <- NEI %>% 
  mutate(year == as_factor(year)) %>% 
  filter(fips =="24510") %>% 
  group_by(year, type) %>% 
  summarise(balt_pm25_point = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = balt_pm25_point, color = type)) +
  geom_line() + 
  labs(x = "Year", y = "pm2.5", title = "pm2.5 emission in the Baltimore City by the types of source")

# export plot
dev.cur()

png(file = "plot3.PNG",width=480, height=480)
nei_baltimore_type

dev.off()

# Answer : Except the type of source "POINT", the other 3 sources have seen decrease in emissions.
#          It has seen increase in "POINT" source.

