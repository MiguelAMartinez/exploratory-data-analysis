# Download raw data from: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")	
SCC <- readRDS("Source_Classification_Code.rds")

# Refine data
balNEI <- NEI[NEI$fips == "24510",]
balNEI <- balNEI %>% group_by(year,type) %>% summarise(Emissions = sum(Emissions))

# Make plot
g <- ggplot(balNEI, aes(year,Emissions))
myplot <- g + geom_point(aes(color = type)) + geom_line(aes(color = type)) + labs(title = "Baltimore PM2.5 Emission Sources per Year") + labs(x = "Years", y = "Emissions (tons)") + theme_bw()
print(myplot)

# Save plot
dev.copy(png, file = "plot3.png", width = 500, height = 500, units = "px") 
dev.off() 