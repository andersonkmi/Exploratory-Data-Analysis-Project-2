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
### Summarizes Baltimore emissions by type
##################################################
baltimoreEmissionsType <- ddply(neiBaltimoreDF, .(year, type), summarize, Emissions = sum(Emissions))

#######################################
### Graph plotting and saving to file
#######################################
print(qplot(year, Emissions, data = baltimoreEmissionsType, group = type, 
      color = type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Yearly Total Emissions in Baltimore by Type of Pollutant"))
ggsave("plot3.png", width=5, height=5, dpi=100)