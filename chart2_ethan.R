WorldCups <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-sws0713/main/WorldCups.csv")

library(dplyr)
library(ggplot2)
library(scales)
library(tidyverse)

HEAD

WorldCups$Attendance <- as.numeric(gsub("\\.","", WorldCups$Attendance))
Attendance_over_years <- ggplot(data = WorldCups, aes(Year, Attendance, group=1)) +
  geom_line() +
  labs(title = "Attendance over the Years", 
       x = "Year", 
       y = "Attendance")


Attendance_over_years



  

WorldCups$Attendance <- as.numeric(gsub("\\.","", WorldCups$Attendance))
Attendance_over_years <- ggplot(data = WorldCups, aes(Year, Attendance, group=1)) +
  geom_line() +
  labs(title = "Attendance over the Years", 
       x = "Year", 
       y = "Attendance")


Attendance_over_years
