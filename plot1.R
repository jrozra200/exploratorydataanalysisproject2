plot1 <- function() {
        library(plyr)
        
        NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
        
        overalltrend <- ddply(NEI, .(year), summarize, sum = sum(Emissions))
        
        png("plot1.png")
        plot(overalltrend$year, overalltrend$sum, pch = ".", xlab = "YEAR", ylab = "Overall Emissions")
        lines(overalltrend$year, overalltrend$sum)
        title(main = "Overall Emissions by Year")
        dev.off()
}