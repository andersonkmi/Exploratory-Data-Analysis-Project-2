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

########################
### Coal related items
########################
sccCoal <- sccDF[grep("Coal", sccDF$SCC.Level.Three),]
coalEmissions <- neiDF[SCC %in% sccCoal$SCC,]
coalTotalEmissions <- with(coalEmissions, aggregate(Emissions, by = list(year), sum))

#########################
### Graph plotting
#########################
png(filename = "plot4.png", width = 480, height = 480, units = "px")
plot(coalTotalEmissions, type = "b", pch = 20, col = "blue", ylab = "Emissions (tons)", xlab = "Years", main = "Coal Yearly Emissions")
dev.off()

