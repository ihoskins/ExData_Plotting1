# Code for plot3: multi-series line plot of submetering against weekday

# Read in all data and reassign missing value character to NA
house_pc<-read.table(file="household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
# Create logical vector of dates that match the dates of interest
doi<-grepl("2007-02-0[1-2]",as.Date(house_pc[["Date"]],format="%d/%m/%Y"))
# Subset main data frame for dates of interest
house_pc_clean<-subset(house_pc,doi)
# Paste date and time character vectors together
date_time_character<-paste(as.character(house_pc_clean[["Date"]]),as.character(house_pc_clean[["Time"]]),sep=" ")
# Create new object containing POSIX-lt class date-times
datetime<-strptime(date_time_character,format="%d/%m/%Y %H:%M:%S",tz="GMT")
# Open png file device
png(filename="plot3.png",width=480,height=480)
# Generate line plot
submetering_legend<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
plot(date_time,house_pc_clean$Sub_metering_1,ylab="Energy sub metering",xlab="",type="n")
lines(date_time,house_pc_clean$Sub_metering_1,col="black")
lines(date_time,house_pc_clean$Sub_metering_2,col="red")
lines(date_time,house_pc_clean$Sub_metering_3,col="blue")
legend(x="topright",legend=submetering_legend,col=c("black","red","blue"),lty=1)
# Close file device
dev.off()