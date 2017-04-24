# Download raw data from: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")	
SCC <- readRDS("Source_Classification_Code.rds")

yearNEI <- NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
plot(yearNEI, main = "Overall PM2.5 Emissions per Year", pch = 19, ylab = "Emissions (tons)", xlab = "Years")
lines(yearNEI$year, yearNEI$Emissions)
dev.copy(png, file = "plot1.png", width = 500, height = 500, units = "px") 
dev.off() 