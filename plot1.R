setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Aggregate
Emissions <- aggregate(NEIdata[, 'Emissions'], by = list(NEIdata$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, 
        main = expression('Total Emission in the US'), 
        xlab = 'Year', 
        ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()