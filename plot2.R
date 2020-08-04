library(dplyr)

if(!file.exists("CourseProject2")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, destfile = "exdata_data_FNEI_data.zip")
  unzip("exdata_data_FNEI_data.zip", exdir="./CourseProject2")
}

NEI <- readRDS("CourseProject2/summarySCC_PM25.rds")
SCC <- readRDS("CourseProject2/Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")
sum_emission <- tapply(baltimore$Emissions, baltimore$year, sum)
png("plot2.png",width=480,height=480,units="px",bg="transparent")
barplot(sum_emission, xlab = "Year", ylab = "PM 2.5 Emissions (Tons)", main = "Total PM 2.5 Emissions From all Baltimore City Sources")
dev.off()