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

## Question 4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

table(SCC$EI.Sector)

scc_coal <- SCC %>% 
  filter(str_detect(EI.Sector, "Coal")) %>% 
  select(SCC) %>% 
  mutate(SCC = as.character(SCC))

scc_coal_v <- scc_coal[,"SCC"]

coal_us <- NEI %>% filter(SCC %in% scc_coal_v) %>% 
  mutate(year = as_factor(year)) %>% 
  group_by(year) %>% 
  summarize(total_pm25 = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = total_pm25, fill = year)) +
  geom_col() +
  labs(x = "Year", y = "pm2.5", title = "Coal combustion-related pm2.5 emission in the United States")


dev.cur()

png(file = "plot4.PNG",width=480, height=480)
coal_us

dev.off()

# Answer : It is decreaed rapidly from 2005 to 2008.
