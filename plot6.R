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

##############################################
### Subsetting to Los Angeles (fips == "06037")
##############################################
neiLosAngelesDF <- subset(neiDF, fips == "06037")
head(neiLosAngelesDF)
str(neiLosAngelesDF)

##########################
### Motor Vehicles items
##########################
motorVehiclesEmissionsScc <- sccDF[grep("[Mm]obile|[Vv]ehicles", sccDF$EI.Sector),]

##########################
## Baltimore aggregation
##########################
motorVehiclesEmissionsBaltimore <- neiBaltimoreDF[SCC %in% motorVehiclesEmissionsScc$SCC,]
motorVehiclesEmissionsBaltimoreAgg <- with(motorVehiclesEmissionsBaltimore, aggregate(Emissions, by = list(year), sum))

##########################
## Baltimore aggregation
##########################
motorVehiclesEmissionsLosAngeles <- neiLosAngelesDF[SCC %in% motorVehiclesEmissionsScc$SCC,]
motorVehiclesEmissionsLosAngelesAgg <- with(motorVehiclesEmissionsLosAngeles, aggregate(Emissions, by = list(year), sum))

#####################
### Graph plotting
#####################
print(ggplot() + geom_line(data = motorVehiclesEmissionsBaltimoreAgg, aes(x = Group.1, y = x, colour = "Baltimore")) + geom_line(data = motorVehiclesEmissionsLosAngelesAgg, aes(x = Group.1, y = x, colour = "Los Angeles")) + xlab("Years") + ylab("Emissions (tons)") + ggtitle("Balmtimore x Los Angeles Emission Comparison"))
ggsave("plot6.png", width=5, height=5, dpi=100)