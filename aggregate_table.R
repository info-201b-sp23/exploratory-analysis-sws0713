library(dplyr)
library(knitr)

setwd("~/Desktop/WorldCup")
winners <- read.csv('WorldCups.csv', stringsAsFactors = FALSE)
worldcup <- read.csv('WorldCupMatches.csv', stringsAsFactors = FALSE)

aggregate_table <- worldcup %>%
  group_by(`Home.Team.Name`) %>%
  summarise(
    TotalMatches = n(),
    TotalWins = sum(`Home.Team.Goals` > `Away.Team.Goals`),
    AverageGoalsScored = round(mean(`Home.Team.Goals`), 2),
    AverageGoalsConceded = round(mean(`Away.Team.Goals`), 2),
    Home.Team.Goals = sum(`Home.Team.Goals`),
    Away.Team.Goals = sum(`Away.Team.Goals`),
    Home.Team.Name = first(`Home.Team.Name`),
    Away.Team.Name = first(`Away.Team.Name`)
  ) %>%
  arrange(desc(TotalWins))

colnames(aggregate_table) <- c("Team", "Total Matches", "Total Wins", "Avg Goals Scored", "Avg Goals Conceded",
                               "Total Home Goals", "Total Away Goals", "World Cup Wins")

