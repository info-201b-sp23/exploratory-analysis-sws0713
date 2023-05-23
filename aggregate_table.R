library(dplyr)

setwd("~/Desktop/WorldCup")

worldcup <- read.csv('WorldCupMatches.csv')
winners <- read.csv('WorldCups.csv')

worldcup_grouped <- worldcup %>%
  group_by(Home.Team.Name) %>%
  summarise(
    Total_Matches = n(),
    Total_Goals_Scored = sum(Home.Team.Goals + Away.Team.Goals),
    Total_Home_Goals = sum(Home.Team.Goals),
    Total_Away_Goals = sum(Away.Team.Goals),
    Average_Attendance = round(mean(Attendance))
  )

winners_grouped <- winners %>%
  group_by(Runners.Up) %>%
  summarise(
    Total_Wins = n(),
    Total_Goals_Scored = sum(GoalsScored),
    Average_Attendance = round(mean(Attendance))
  )

colnames(worldcup_grouped) <- c("Team", "Total Matches", "Total Goals Scored", "Total Home Goals", "Total Away Goals", "Average Attendance")

colnames(winners_grouped) <- c("Team", "Total Wins", "Total Goals Scored", "Total Home Goals", "Total Away Goals", "Average Attendance")


