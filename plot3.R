library(ggplot2)

setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Extract data for Baltimore City
Baltimore <- NEIdata[NEIdata$fips == "24510", ] 

par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot3.png")
ggplot(Baltimore, aes(year, Emissions, color = type)) +
geom_line(stat = "summary", fun.y = "sum") +
ylab(expression('Total PM'[2.5]*" Emissions")) +
ggtitle("Total Emissions in Baltimore City, MD by source type")
dev.off()


