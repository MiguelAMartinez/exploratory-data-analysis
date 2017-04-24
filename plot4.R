# Download raw data from: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")	
SCC <- readRDS("Source_Classification_Code.rds")

# Refine data, select SCC values associated with coal combustion 
coalValues <- SCC[grep("Comb(.*)Coal", SCC$Short.Name), ]
coalNEI <- NEI[NEI$SCC %in% as.character(coalValues$SCC), ]
groupNEI <- coalNEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

# Make plot
g <- ggplot(groupNEI, aes(year,Emissions))
myplot <- g + geom_point(color = "steelblue") + geom_line(color = "steelblue") + labs(title = "PM2.5 Emissions from Coal Combustion per Year") + labs(x = "Years", y = "Emissions (tons)") + theme_bw()
print(myplot)

# Save plot
dev.copy(png, file = "plot4.png", width = 500, height = 500, units = "px") 
dev.off() 