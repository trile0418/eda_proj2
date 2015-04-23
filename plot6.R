library(ggplot2)

setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

NEIdata$year <- factor(NEIdata$year, levels = c('1999', '2002', '2005', '2008'))

#  Extract data for Baltimore city and Los Angeles
Baltimore.onroad <- subset(NEIdata, fips == '24510' & type == 'ON-ROAD')
LA.onroad <- subset(NEIdata, fips == '06037' & type == 'ON-ROAD')

# Aggregate
Baltimore.DF <- aggregate(Baltimore.onroad[, 'Emissions'], by = list(Baltimore.onroad$year), sum)
colnames(Baltimore.DF) <- c('year', 'Emissions')
Baltimore.DF$City <- paste(rep('Baltimore', 4))

LA.DF <- aggregate(LA.onroad[, 'Emissions'], by = list(LA.onroad$year), sum)
colnames(LA.DF) <- c('year', 'Emissions')
LA.DF$City <- paste(rep('LA', 4))

DF <- as.data.frame(rbind(Baltimore.DF, LA.DF))

png('plot6.png')
ggplot(data = DF, aes(x = year, y = Emissions)) + 
geom_bar(aes(fill = year),stat = "identity") + 
guides(fill = F) + 
ggtitle('Total Emissions from Motor Vehicle Sources\nBaltimore City, MD vs. Los Angeles County, CA') + 
ylab(expression(paste('PM', ''[2.5], ' in Kilotons'))) + 
xlab('Year') + 
theme(legend.position = 'none') + 
facet_grid(. ~ City) + 
geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
dev.off()