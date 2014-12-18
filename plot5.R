plot5 <- function() {
        library(plyr)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
        
        totalData <- merge(NEI, SCC, by = "SCC")
        
        mv <- grep("^Highway Veh*", totalData$Short.Name)
        
        mvdata <- totalData[mv, ]
        
        mvbmoredata <- mvdata[mvdata$fips == "24510", ]
        
        mvbmorebreakdown <- ddply(mvbmoredata, .(year), summarize, sum = sum(Emissions))
        
        png("plot5.png")
        plot(mvbmorebreakdown$year, mvbmorebreakdown$sum, pch = ".", xlab = "YEAR", ylab = "Overall Emissions")
        lines(mvbmorebreakdown$year, mvbmorebreakdown$sum)
        title(main = "Overall Emissions from Coal Related Sources by Year")
        dev.off()
}