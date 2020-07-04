library(tidyverse)

wd <- getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(wd,"/2FNEI_data.zip"))

unzip("2FNEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)
str(NEI)
str(SCC)

## Question 6 : Compare emissions from motor vehicle sources in Baltimore City 
##              with emissions from motor vehicle sources in Los Angeles County, California. 
##              Which city has seen greater changes over time in motor vehicle emissions?


scc_onroad <- SCC %>% 
  filter(Data.Category =="Onroad") %>%
  select(SCC) %>% 
  mutate(SCC = as.character(SCC))

scc_onroad_v <- scc_onroad[,"SCC"]

scc_onroad_bal_la <- NEI %>% 
  filter(SCC %in% scc_onroad_v & fips %in% c("24510", "06037")) %>% 
  mutate(year = as_factor(year),
         city = case_when(fips == "24510" ~ "Baltimore City",
                          fips == "06037" ~ " Los Angeles County"),
         city = as_factor(city)) %>% 
  group_by(year, city) %>% 
  summarize(pm25 = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = pm25, fill = city))+
  geom_col(position = "dodge") +
  labs(x = "Year", y = "pm2.5", title = "pm2.5 emissions from motor vehicle in Baltimore and Los Angeles")

dev.cur()

png(file = "plot6.PNG",width=480, height=480)
scc_onroad_bal_la 

dev.off()

# Answer : It is decreased continuously in Baltimore from 1999 to 2008.
#          However it is increased in LA from 1999 to 2005 and decreased from 2005 to 2008.        