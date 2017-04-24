# Download raw data from: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)

#Read data
NEI <- readRDS("summarySCC_PM25.rds")	
SCC <- readRDS("Source_Classification_Code.rds")

# Make plot
balNEI <- NEI[NEI$fips == "24510",]
balNEI <- balNEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
plot(balNEI, main = "Baltimore PM2.5 Emissions per Year", pch = 19, ylab = "Emissions (tons)", xlab = "Years")
lines(balNEI$year, balNEI$Emissions)

# Save plot
dev.copy(png, file = "plot2.png", width = 500, height = 500, units = "px") 
dev.off() 