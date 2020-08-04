library(dplyr)

if(!file.exists("CourseProject2")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, destfile = "exdata_data_FNEI_data.zip")
  unzip("exdata_data_FNEI_data.zip", exdir="./CourseProject2")
}

NEI <- readRDS("CourseProject2/summarySCC_PM25.rds")
SCC <- readRDS("CourseProject2/Source_Classification_Code.rds")

str(NEI)
str(SCC)
coal <- SCC[grep("coal|Coal", SCC$Short.Name),]
NEI4 <- subset(NEI, SCC%in%coal$SCC )
png("plot4.png",width=480,height=480,units="px",bg="transparent")
sum_coal <- tapply(NEI4$Emissions, NEI4$year, sum)
barplot( sum_coal/10^6, main = "Sum of PM2.5 emission from coal", xlab = "Year", ylab="PM2.5 emitted (10^6 tons)")
dev.off()