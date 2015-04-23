library(ggplot2)

setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

NEIdata$year <- factor(NEIdata$year, levels = c('1999', '2002', '2005', '2008'))

# Extract data for Baltimore City
Baltimore.onroad <- subset(NEIdata, fips == 24510 & type == 'ON-ROAD')

# Aggregate
Baltimore.df <- aggregate(Baltimore.onroad[, 'Emissions'], by = list(Baltimore.onroad$year), sum)
colnames(Baltimore.df) <- c('year', 'Emissions')

png('plot5.png')
ggplot(data = Baltimore.df, aes(x = year, y = Emissions)) + 
geom_bar(aes(fill = year), stat = "identity") + 
guides(fill = F) + 
ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore City, MD') + 
ylab(expression(paste('PM', ''[2.5], ' in Kilotons'))) + 
xlab('Year') + theme(legend.position = 'none') + 
geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
dev.off()