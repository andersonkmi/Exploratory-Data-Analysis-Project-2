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

##############################################
### Subsetting to Baltimore (fips == "24510")
##############################################
neiBaltimoreDF <- subset(neiDF, fips == "24510")
head(neiBaltimoreDF)
str(neiBaltimoreDF)

##################################################
### Aggregate PM25 emissions using Baltimore data
##################################################
pm25BaltimoreTotalEmissions <- with(neiBaltimoreDF, aggregate(Emissions, by = list(year), sum))
head(pm25BaltimoreTotalEmissions)
str(pm25BaltimoreTotalEmissions)

#####################
### Graph plotting
#####################
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(pm25BaltimoreTotalEmissions, type = "b", pch = 20, col = "green", ylab = "Emissions (tons)", xlab = "Years", main = "Baltimore Yearly Emissions")
dev.off()

