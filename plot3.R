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
NEI1 <- group_by(baltimore, type, year)%>%summarise(Total=sum(Emissions))
png("plot3.png",width=480,height=480,units="px",bg="transparent")
p <- ggplot(NEI1, aes(x=as.factor(year), y=Total, fill=type))+geom_col(position="dodge")+facet_grid(cols= vars(type))+xlab("Year")+ylab("PM2.5 emitted (tons)")+labs(title="PM2.5 emission per type-Baltimore")+theme(axis.text.x = element_text(angle = 90))
p

dev.off()