library(dplyr)
libary(ggplot2)

if(!file.exists("CourseProject2")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, destfile = "exdata_data_FNEI_data.zip")
  unzip("exdata_data_FNEI_data.zip", exdir="./CourseProject2")
}

NEI <- readRDS("CourseProject2/summarySCC_PM25.rds")
SCC <- readRDS("CourseProject2/Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")
la <- subset(NEI, fips=="06037")


motor <- SCC[grep("Mobile", SCC$EI.Sector, ignore.case =TRUE),]
motor <- motor[!grepl("aircraft", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("railroad", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("marine", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("Pleasure Craft", motor$SCC.Level.Two, ignore.case =TRUE),]


NEI5 <- subset(baltimore, SCC%in%motor$SCC )
NEI6 <- subset(la, SCC%in%motor$SCC )
png("plot6.png", height = 480, width = 600)
sum_motor_b <- tapply(NEI5$Emissions, NEI5$year, sum)
sum_motor_l <- tapply(NEI6$Emissions, NEI6$year, sum)
par(mfrow=c(1,2))
barplot(sum_motor_b, main = "Emission from motor vehicle in Baltimore", xlab = "Year", ylab="PM2.5 emitted (tons)",cex.main=0.8, cex.lab=0.8, cex.names = 0.8)
barplot(sum_motor_l, main = "Emission from motor vehicle in LA", xlab = "Year", ylab="PM2.5 emitted (tons)",cex.main=0.8,cex.lab=0.8, cex.names = 0.8)

dev.off()