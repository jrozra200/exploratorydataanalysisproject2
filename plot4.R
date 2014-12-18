plot4 <- function() {
        library(plyr)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
        
        totalData <- merge(NEI, SCC, by = "SCC")
        
        coal <- grep("*[Cc]oal*", totalData$Short.Name)
        
        coaltotal <- totalData[coal, ]
        
        coalbreakdown <- ddply(coaltotal, .(year), summarize, sum = sum(Emissions))
        
        png("plot4.png")
        plot(coalbreakdown$year, coalbreakdown$sum, pch = ".", xlab = "YEAR", ylab = "Overall Emissions")
        lines(coalbreakdown$year, coalbreakdown$sum)
        title(main = "Overall Emissions from Coal Related Sources by Year")
        dev.off()
}