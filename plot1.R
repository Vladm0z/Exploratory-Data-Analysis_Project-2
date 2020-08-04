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
sum_emission <- tapply(NEI$Emissions, NEI$year, sum)
png("plot1.png",width=480,height=480,units="px",bg="transparent")
barplot(sum_emission/10^6, main = "Sum of PM2.5 emission from all US sources", xlab = "Years", ylab="PM2.5 emitted (10^6 tons)")
dev.off()