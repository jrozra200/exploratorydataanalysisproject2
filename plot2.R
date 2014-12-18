plot2 <- function() {
        library(plyr)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        
        baltimore <- NEI[NEI$fips == "24510", ]
        
        overalltrend <- ddply(baltimore, .(year), summarize, sum = sum(Emissions))
        
        png("plot2.png")
        plot(overalltrend$year, overalltrend$sum, pch = ".", xlab = "YEAR", ylab = "Overall Emissions")
        lines(overalltrend$year, overalltrend$sum)
        title(main = "Overall Emissions by Year (for Baltimore)")
        dev.off()
}