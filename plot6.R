plot6 <- function() {
        library(plyr)
        library(ggplot2)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
        
        totalData <- merge(NEI, SCC, by = "SCC")
        
        mv <- grep("^Highway Veh*", totalData$Short.Name)
        
        mvdata <- totalData[mv, ]
        
        mvbmoredata <- mvdata[mvdata$fips == "24510", ]
        mvladata <- mvdata[mvdata$fips == "06037", ]
        
        mvbmorebreakdown <- ddply(mvbmoredata, .(year), summarize, sum = sum(Emissions))
        mvbmorebreakdown <- cbind(mvbmorebreakdown, area = "Baltimore City")
        mvlabreakdown <- ddply(mvladata, .(year), summarize, sum = sum(Emissions))
        mvlabreakdown <- cbind(mvlabreakdown, area = "Los Angeles County")
        
        totalbreakdown <- rbind(mvbmorebreakdown, mvlabreakdown)
        
        totalbreakdownplot <- ggplot(totalbreakdown, aes(year, sum)) + geom_line() + facet_grid(.~area) + labs(x = "Year", y = "Overall Emissions") + labs(title = "Overall Motor Vehicle Emissions by Year by Area")
        
        png("plot6.png")
        print(totalbreakdownplot)
        dev.off()
}