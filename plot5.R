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
motor <- SCC[grep("Mobile", SCC$EI.Sector, ignore.case =TRUE),]
motor <- motor[!grepl("aircraft", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("railroad", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("marine", motor$SCC.Level.Two, ignore.case =TRUE),]
motor <- motor[!grepl("Pleasure Craft", motor$SCC.Level.Two, ignore.case =TRUE),]

NEI5 <- subset(baltimore, SCC%in%motor$SCC )
png("plot5.png",width=480,height=480,units="px",bg="transparent")
sum_motor <- tapply(NEI5$Emissions, NEI5$year, sum)
barplot( sum_motor, main = "Sum of PM2.5 emission from motor vehicle in Baltimore", xlab = "Year", ylab="PM2.5 emitted (tons)")

dev.off()