library(ggplot2)

setwd("D:/Downloads/DataScience/Coursera/Exploratory_Data_Analysis/Rcodes")

# Load RDS
NEIdata <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Extract data for Coal-related SCC
SCCdata.coal = SCCdata[grepl("coal", SCCdata$Short.Name, ignore.case = TRUE), ]

# Merges two data sets
merge <- merge(x = NEIdata, y = SCCdata.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

png(filename = 'plot4.png')
ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000)) + 
geom_line(aes(group = 1, col = Emissions)) + 
geom_point(aes(size = 2, col = Emissions)) + 
ggtitle(expression('Total Emissions from coal combustion-related sources in the US')) + 
ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
theme(legend.position = 'none') + scale_colour_gradient(low = 'black', high = 'red')
dev.off()