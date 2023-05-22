WorldCups <- read.csv("WorldCups.csv")

library(dplyr)
library(ggplot2)
library(scales)
library(tidyverse)
WorldCups$Attendance <- WorldCups$Attendance.gsub("\.","", WorldCups$Attendance)
checkouts_line_by_book <- ggplot(data = WorldCups) +
  geom_line(aes(x = Year, y = Attendance)) +
  labs(title = "Attendance over the Years", 
       x = "Date", 
       y = "Total Checkouts")

checkouts_line_by_book
