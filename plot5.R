library(tidyverse)

wd <- getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(wd,"/2FNEI_data.zip"))

unzip("2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Question 5 : How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


scc_onroad <- SCC %>% 
  filter(Data.Category =="Onroad") %>%
  select(SCC) %>% 
  mutate(SCC = as.character(SCC))

scc_onroad_v <- scc_onroad[,"SCC"]

scc_onroad <- NEI %>% 
  filter(SCC %in% scc_onroad_v & fips == "24510") %>% 
  mutate(year = as_factor(year)) %>% 
  group_by(year) %>% 
  summarize(pm25 = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = pm25, fill = year))+
  geom_col() +
  labs(x = "Year", y = "pm2.5", title = "pm2.5 emissions from motor vehicle sources in the Baltimore City")

dev.cur()

png(file = "plot5.PNG",width=480, height=480)
scc_onroad 

dev.off()

# Answer : It is decreased rapidly from 1999 to 2002 and decreased continuously.