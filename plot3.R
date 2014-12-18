plot3 <- function() {
        library(plyr)
        library(ggplot2)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        
        baltimore <- NEI[NEI$fips == "24510", ]
        
        baltimorepoint <- baltimore[baltimore$type == "POINT", ]
        baltimorenonpoint <- baltimore[baltimore$type == "NONPOINT", ]
        baltimoreonroad <- baltimore[baltimore$type == "ON-ROAD", ]
        baltimorenonroad <- baltimore[baltimore$type == "NON-ROAD", ]
        
        pointtrend <- ddply(baltimorepoint, .(year), summarize, sum = sum(Emissions))
        pointtrend <- cbind(pointtrend, type = "POINT")
        nonpointtrend <- ddply(baltimorenonpoint, .(year), summarize, sum = sum(Emissions))
        nonpointtrend <- cbind(nonpointtrend, type = "NONPOINT")
        onroadtrend <- ddply(baltimoreonroad, .(year), summarize, sum = sum(Emissions))
        onroadtrend <- cbind(onroadtrend, type = "ON-ROAD")
        nonroadtrend <- ddply(baltimorenonroad, .(year), summarize, sum = sum(Emissions))
        nonroadtrend <- cbind(nonroadtrend, type = "NON-ROAD")
        
        bmorebreakdown <- rbind(pointtrend, nonpointtrend, onroadtrend, nonroadtrend)
        
        bmorebreakdownplot <- ggplot(bmorebreakdown, aes(year, sum)) + geom_line() + facet_grid(.~type) + labs(x = "Year", y = "Overall Emissions") + labs(title = "Overall Emissions by Year by Type")
        
        png("plot3.png")
        print(bmorebreakdownplot)
        dev.off()
}