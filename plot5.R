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

##########################
### Motor Vehicles items
##########################
motorVehiclesEmissionsScc <- sccDF[grep("[Mm]obile|[Vv]ehicles", sccDF$EI.Sector),]
motorVehiclesEmissionsBaltimore <- neiBaltimoreDF[SCC %in% motorVehiclesEmissionsScc$SCC,]
motorVehiclesEmissionsBaltimoreAgg <- with(motorVehiclesEmissionsBaltimore, aggregate(Emissions, by = list(year), sum))

#####################
### Graph plotting
#####################
png(filename = "plot5.png", width = 480, height = 480, units = "px")
plot(motorVehiclesEmissionsBaltimoreAgg, type = "b", pch = 20, col = "orange", ylab = "Motor Vehicle Emissions (tons)", xlab = "Years", main = "Baltimore Yearly Motor Vehicle Emissions")
dev.off()

