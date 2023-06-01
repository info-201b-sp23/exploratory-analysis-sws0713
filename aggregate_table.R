library(dplyr)
library(knitr)

WorldCupMatches <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-sws0713/main/WorldCupMatches.csv")

winners <- read.csv('~/Desktop/Info-201/exploratory-analysis-sws0713/WorldCups.csv')

# calculate the home stats for each team
home_team_stats <- WorldCupMatches %>%
  group_by(`Home.Team.Name`) %>%
  summarize(
    Total_Home = n(),
    Total_Goals_Home = sum(`Home.Team.Goals`),
    Total_Conceded_Home = sum(`Away.Team.Goals`),
    Avg_Home_Attendance = round(mean(Attendance))
  )

# calculate the away stats for each team
away_team_stats <- WorldCupMatches %>%
  group_by(`Away.Team.Name`) %>%
  summarize(
    Total_Away = n(),
    Total_Goals_Away = sum(`Away.Team.Goals`),
    Total_Conceded_Away = sum(`Home.Team.Goals`),
    Avg_Away_Attendance = round(mean(Attendance))
  )

# combine
team_goal_stats <- full_join(home_team_stats, away_team_stats, by = c("Home.Team.Name" = "Away.Team.Name")) %>%
  group_by(Home.Team.Name) %>%
  summarize(
    Total_Matches = Total_Home + Total_Away,
    Total_Goals = Total_Goals_Home + Total_Goals_Away,
    Total_Conceded = Total_Conceded_Home + Total_Conceded_Away,
    Goal_Ratio = round(Total_Goals / Total_Conceded, digits = 2),
    Avg_Attendance = round((Avg_Home_Attendance + Avg_Away_Attendance) / 2)
  ) %>%
  rename(
    "Team" = Home.Team.Name,
    "Matches Played" = Total_Matches,
    "Goals Scored" = Total_Goals,
    "Goals Conceded" = Total_Conceded,
    "Goal Ratio" = Goal_Ratio,
    "Average Attendance" = Avg_Attendance
  )

kable(team_goal_stats)