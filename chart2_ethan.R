WorldCups <- read.csv("WorldCups.csv")

library(dplyr)
library(ggplot2)
library(scales)
library(tidyverse)


WorldCups$Attendance <- as.numeric(gsub("\\.","", WorldCups$Attendance))
Attendance_over_years <- ggplot(data = WorldCups, aes(Year, Attendance, group=1)) +
  geom_line() +
  labs(title = "Attendance over the Years", 
       x = "Year", 
       y = "Attendance")


Attendance_over_years



  