setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Extract data for Baltimore City
Baltimore <- subset(NEIdata, fips == '24510')

png(filename = 'plot2.png')
barplot(tapply(X = Baltimore$Emissions, INDEX = Baltimore$year, FUN = sum), 
        main = 'Total Emission in Baltimore City, MD', 
        xlab = 'Year', 
        ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()