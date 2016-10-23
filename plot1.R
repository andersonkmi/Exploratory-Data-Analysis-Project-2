#######################
### Library loading
#######################
library(plyr)
library(ggplot2)
library(data.table)

#######################
### Loading data sets
#######################
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#################################
### Convert them to data tables
#################################
neiDF <- data.table(nei)
sccDF <- data.table(scc)
head(neiDF)
head(sccDF)
summary(neiDF)
summary(sccDF)

#################################
### Calculate yearly aggregation
#################################
pm25YearlyTotalEmissions <- with(neiDF, aggregate(Emissions, by = list(year), sum))
head(pm25YearlyTotalEmissions)
str(pm25YearlyTotalEmissions)

#####################
### Graph plotting
#####################
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(pm25YearlyTotalEmissions, type = "b", pch = 20, col = "red", ylab = "Emissions (tons)", xlab = "Years", main = "Yearly Emissions")
dev.off()
