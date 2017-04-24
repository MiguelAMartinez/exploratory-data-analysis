# Download raw data from: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")	
SCC <- readRDS("Source_Classification_Code.rds")

# Refine data, select SCC values associated with vehicles in Baltimore and Los Angeles
cityNEI <- NEI[NEI$fip %in% c("24510","06037"),]
vehiValues <- SCC[grep("Vehicle", SCC$EI.Sector), ]
vehiNEI <- cityNEI[cityNEI$SCC %in% as.character(vehiValues$SCC), ]
groupNEI <- vehiNEI %>% group_by(year,fips) %>% summarise(Emissions = sum(Emissions))
groupNEI <- rename(groupNEI, City = fips)
groupNEI$City <- gsub("24510","Baltimore", groupNEI$City)
groupNEI$City <- gsub("06037","Los Angeles", groupNEI$City)

# Make plot
g <- ggplot(groupNEI, aes(year,Emissions))
myplot <- g + geom_point(aes(color = City)) + geom_line(aes(color = City)) + labs(title = "PM2.5 Emissions from Vehicles in Baltimore and LA per Year") + labs(x = "Years", y = "Emissions (tons)") + theme_bw()
print(myplot)

# Save plot
dev.copy(png, file = "plot6.png", width = 500, height = 500, units = "px") 
dev.off() 